# frozen_string_literal: true

module YardMd
  # The documentation of every gem the current project's bundle resolves on
  # this platform, written as Markdown into one directory per gem version.
  #
  # {#document} has the bundle resolved by the project's own Ruby through
  # <tt>mise exec</tt> where mise is installed, otherwise by the +ruby+ on the
  # PATH, so it need not be the Ruby yard-md runs on. mise installs no missing
  # tool for it. {#read} takes the versions from the project's lockfile alone.
  #
  # The output directory is a cache: a gem whose <tt><gem>-<version></tt> directory
  # exists is skipped unless forced, and a directory appears only once its gem
  # is fully documented, so an interrupted or concurrent run leaves no partial
  # one; what a run killed on this machine left half-written, the next run
  # removes. Several projects can share it.
  #
  # @example
  #   YardMd::Bundle.new.document
  #   YardMd::Bundle.new.read("YARD::Registry.at")
  class Bundle
    # A gem at its version; resolved, also its code under +root+, all of it or
    # only +files+, and its own directory at +path+.
    # @api private
    Spec = Data.define(:name, :version, :path, :root, :files) do
      def initialize(name:, version:, path:, root: path, files: [])
        super
      end
    end

    # @api private
    Namespace = Struct.new(:kind, :constants, :methods, :gems) do
      def initialize(kind:, constants: {}, methods: {}, gems: [])
        super
      end
    end

    # @api private
    SCRATCH = ".yard-md-"

    # @api private
    NOUNS = {"constant" => "constants", "module" => "modules", "class" => "classes", "method" => "methods"}.freeze

    # Run by the project's Ruby, it writes into the file named by its argument
    # the bundle's {Spec}s, or Bundler's error, as JSON; what the Gemfile
    # prints goes wherever it goes.
    # @api private
    RESOLVER = <<~RUBY
      require "bundler"
      require "json"

      Bundler.ui = Bundler::UI::Silent.new
      lib = RbConfig::CONFIG["rubylibdir"]
      result = begin
        specs = Bundler.definition.specs.map do |spec|
          entry = {name: spec.name, version: spec.version.to_s, path: spec.full_gem_path}
          next entry unless spec.default_gem?

          files = spec.files.filter_map do |file|
            file = file.delete_prefix("lib/")
            file if file.end_with?(".rb") && File.file?(File.join(lib, file))
          end
          entry.merge(root: lib, files: files)
        end
        {specs: specs}
      rescue Bundler::BundlerError => error
        {error: error.message}
      end
      File.write(ARGV.fetch(0), JSON.generate(result))
    RUBY

    # @param output [String] the directory to write into, created when missing,
    #   and read from
    # @param force [Boolean] rebuild the bundle's gems whose directories exist,
    #   replacing each only once its rebuild succeeds; other directories in
    #   +output+ are left alone
    def initialize(output = CACHE, force: false)
      @output = File.expand_path(output)
      @force = force
    end

    # Documents each gem not documented yet, or every gem when forced, printing
    # its <tt><gem>-<version></tt> to stdout. A gem that fails is reported on
    # stderr and skipped; the rest go on. The code YARD could not process in a
    # gem is reported on stderr under the gem's name, without YARD's stack
    # traces; the gem still counts as documented.
    #
    # @return [Boolean] whether every gem is documented
    # @raise [Error] when the bundle cannot be resolved, e.g. a gem in it is not
    #   installed
    def document
      resolved = specs
      FileUtils.mkdir_p(@output)
      sweep
      resolved.map { |spec| build(spec) }.all?
    end

    # Answers from the documentation {#document} wrote for the bundle's gems, at
    # the versions the project's lockfile locks, found as Bundler finds it, plus
    # the bundler gem at its <tt>BUNDLED WITH</tt> version, gem by gem in name
    # order. A gem not documented yet, or documented by yard-md 0.1.0, which
    # wrote no index, does not answer.
    #
    # @param address [String] a constant, or a method of one:
    #   <tt>Faraday</tt>, <tt>Faraday::VERSION</tt>,
    #   <tt>Faraday::Connection#run_request</tt>, <tt>Faraday.new</tt>; an
    #   empty constant is the top-level namespace: <tt>""</tt>, <tt>#puts</tt>
    # @return [String] for a class or module, its own documentation from every
    #   gem that documents it, then its list: one line per constant, class or
    #   module, and method in it, from every gem that has them, each with what
    #   lies behind it (a constant's value, a class's or module's kind and
    #   counts, a method's summary), or, when it has nothing to list, one line
    #   with its kind and gems
    # @return [String] for a value constant or a method, its block of the page,
    #   from every gem that documents it
    # @return [nil] when no gem documents it
    # @raise [Error] when the project has no Gemfile or lockfile, or Bundler
    #   cannot read the lockfile
    def read(address)
      constant, method = address.match(/\A([^#.]*)(.*)\z/m).captures
      indexes = locked.filter_map do |spec|
        file = File.join(directory(spec), INDEX)
        index = JSON.parse(File.read(file)) if File.exist?(file)
        [spec, index] if index&.dig("", "kind")
      end
      return blocks(indexes, constant, "methods", method) unless method.empty?

      namespace, _, name = constant.rpartition("::")
      list = listing(indexes, constant)
      return blocks(indexes, namespace, "constants", name) unless list

      [*indexes.filter_map { |spec, index| slice(spec, index, constant, index.dig(constant, "docs", "lines")) }, list].join("\n")
    end

    private

    def specs
      Tempfile.create("yard-md-bundle") do |answer|
        _, err, = ruby("-e", RESOLVER, answer.path)
        raise Error, err.strip if answer.size.zero?

        result = JSON.parse(answer.read, symbolize_names: true)
        raise Error, result[:error] if result[:error]

        result[:specs].map { |spec| Spec.new(**spec) }
      end
    end

    def locked
      lockfile = Bundler.default_lockfile
      raise Error, "Could not locate #{lockfile.basename}" unless lockfile.file?

      parser = Bundler::LockfileParser.new(Bundler.read_file(lockfile))
      versions = parser.specs.map { |spec| [spec.name, spec.version.to_s] }
      versions << ["bundler", parser.bundler_version.to_s] if parser.bundler_version
      versions.uniq.sort.map { |name, version| Spec.new(name: name, version: version, path: nil) }
    rescue Bundler::BundlerError => error
      raise Error, error.message
    end

    def ruby(*args)
      Open3.capture3({"MISE_EXEC_AUTO_INSTALL" => "false"}, "mise", "exec", "--", "ruby", *args)
    rescue Errno::ENOENT
      Open3.capture3("ruby", *args)
    end

    def directory(spec)
      File.join(@output, "#{spec.name}-#{spec.version}")
    end

    def listing(indexes, constant)
      namespaces = namespaces(indexes, constant)
      namespace = namespaces[constant]
      children = namespaces.keys.select { |path| inside?(path, constant) }.sort
      return unless namespace || children.any?

      held = held(namespaces)
      lines = [
        *namespace&.constants&.sort&.map { |name, detail| constant_line(qualified(constant, name), detail) },
        *children.map { |path| [path, [namespaces[path].kind, *counts(held[path])].join(", ")].join(" — ") },
        *namespace&.methods&.map { |name, detail| [name, detail["summary"]].compact.join(" — ") }
      ]
      return lines.map { |line| "#{line}\n" }.join if lines.any?

      "#{constant} — #{namespace.kind} in #{namespace.gems.join(", ")}, with no constants, classes or methods\n"
    end

    def held(namespaces)
      namespaces.each_with_object(Hash.new { |held, path| held[path] = Hash.new(0) }) do |(path, namespace), held|
        held[path]["constant"] += namespace.constants.size
        held[path]["method"] += namespace.methods.size
        held[parent(path)][namespace.kind] += 1 unless path.empty?
      end
    end

    def namespaces(indexes, constant)
      indexes.each_with_object({}) do |(spec, index), namespaces|
        index.each do |path, entry|
          next unless path == constant || inside?(path, constant) || inside?(parent(path), constant)

          namespace = namespaces[path] ||= Namespace.new(kind: entry["kind"])
          namespace.constants = entry.fetch("constants", {}).merge(namespace.constants)
          namespace.methods = namespace.methods.merge(entry.fetch("methods", {})) { |_, first, _| first }
          namespace.gems << "#{spec.name} #{spec.version}"
        end
      end
    end

    def counts(held)
      NOUNS.filter_map { |noun, plural| "#{held[noun]} #{(held[noun] == 1) ? noun : plural}" if held[noun].positive? }
    end

    def constant_line(path, detail)
      detail.key?("value") ? "#{path} = #{detail["value"]}" : "#{path} — #{detail["size"]}"
    end

    def blocks(indexes, namespace, group, name)
      blocks = indexes.filter_map { |spec, index| slice(spec, index, namespace, index.dig(namespace, group, name, "lines")) }
      blocks.join("\n") unless blocks.empty?
    end

    def slice(spec, index, namespace, lines)
      first, last = lines
      File.readlines(File.join(directory(spec), index.dig(namespace, "page")))[(first - 1)...last].join if first
    end

    def inside?(path, namespace)
      path != namespace && parent(path) == namespace
    end

    def parent(path)
      path.rpartition("::").first
    end

    def qualified(namespace, name)
      namespace.empty? ? name : "#{namespace}::#{name}"
    end

    def build(spec)
      target = directory(spec)
      name = File.basename(target)
      return true if !@force && File.exist?(target)

      staging = Dir.mktmpdir(scratch(name), @output)
      return false unless write(spec, name, staging)

      publish(staging, target)
      puts name
      true
    ensure
      FileUtils.rm_rf(staging) if staging
    end

    def write(spec, name, staging)
      # YARD's registry, tag library and logger are process-wide, and a gem's
      # .yardopts changes them; a process per gem keeps one gem out of the next.
      log = StringIO.new
      pid = fork do
        GemDocs.new(spec).write(staging, log)
        warn "yard-md: #{name}:", *log.string.lines unless log.string.empty?
        exit!(true)
      rescue => error
        warn "yard-md: #{name}: #{error.class}: #{error.message}", *log.string.lines
        exit!(false)
      end
      Process.wait2(pid).last.success?
    end

    def publish(staging, target)
      retire(target) if @force && File.exist?(target)
      File.rename(staging, target)
    rescue Errno::EEXIST, Errno::ENOTEMPTY
      nil
    end

    def retire(target)
      Dir.mktmpdir(scratch(File.basename(target)), @output) do |retired|
        File.rename(target, File.join(retired, "docs"))
      rescue Errno::ENOENT
        nil
      end
    end

    def scratch(name)
      "#{SCRATCH}#{Process.pid}-#{name}-"
    end

    def sweep
      Dir.glob("#{SCRATCH}*", base: @output).each do |entry|
        FileUtils.rm_rf(File.join(@output, entry)) unless alive?(entry.delete_prefix(SCRATCH).to_i)
      end
    end

    def alive?(pid)
      Process.kill(0, pid)
    rescue Errno::ESRCH
      false
    rescue Errno::EPERM
      true
    end
  end
end
