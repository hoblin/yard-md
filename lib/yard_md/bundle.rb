# frozen_string_literal: true

module YardMd
  # The documentation of every gem the current project's bundle resolves on
  # this platform, written as Markdown into one directory per gem version.
  #
  # The bundle is resolved by the project's own Ruby through <tt>mise exec</tt>
  # where mise is installed, otherwise by the +ruby+ on the PATH, so it need not
  # be the Ruby yard-md runs on. mise installs no missing tool for it.
  #
  # The output directory is a cache: a gem whose <tt><gem>-<version></tt> directory
  # exists is skipped unless forced, and a directory appears only once its gem
  # is fully documented, so an interrupted or concurrent run leaves no partial
  # one. Several projects can share it.
  #
  # @example
  #   YardMd::Bundle.new.document
  #   YardMd::Bundle.new.read("YARD::Registry.at")
  class Bundle
    # A resolved gem: its code under +root+, all of it or only +files+, and its
    # own directory at +path+.
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
    NOUNS = {"module" => "modules", "class" => "classes", "method" => "methods"}.freeze

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
      resolved.map { |spec| build(spec) }.all?
    end

    # Answers from the documentation {#document} wrote for the bundle's gems, at
    # the versions it resolves. A gem not documented yet, or documented by
    # yard-md 0.1.0, which wrote no index, does not answer.
    #
    # @param address [String] a constant, or a method of one:
    #   <tt>Faraday</tt>, <tt>Faraday::VERSION</tt>,
    #   <tt>Faraday::Connection#get</tt>, <tt>Faraday.new</tt>; an empty
    #   constant is the top-level namespace: <tt>""</tt>, <tt>#puts</tt>
    # @return [String] for a class or module, one line per constant, class or
    #   module, and method in it, from every gem that has them, each with what
    #   lies behind it: a constant's value, a class's or module's kind and
    #   counts, a method's summary; when it has nothing to list, one line with
    #   its kind and gems; for a value constant or a method, its block of the
    #   page, from every gem that documents it
    # @return [nil] when no gem documents it
    # @raise [Error] when the bundle cannot be resolved
    def read(address)
      constant, method = address.match(/\A([^#.]*)(.*)\z/m).captures
      indexes = specs.filter_map do |spec|
        file = File.join(directory(spec), INDEX)
        index = JSON.parse(File.read(file)) if File.exist?(file)
        [spec, index] if index&.dig("", "kind")
      end
      return blocks(indexes, constant, "methods", method) unless method.empty?

      namespace, _, name = constant.rpartition("::")
      listing(indexes, constant) || blocks(indexes, namespace, "constants", name)
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

      lines = [
        *namespace&.constants&.sort&.map { |name, detail| constant_line(qualified(constant, name), detail["value"]) },
        *children.map { |path| [path, [namespaces[path].kind, *counts(namespaces, path)].join(", ")].join(" — ") },
        *namespace&.methods&.map { |name, detail| [name, detail["summary"]].compact.join(" — ") }
      ]
      return lines.map { |line| "#{line}\n" }.join if lines.any?

      "#{constant} — #{namespace.kind} in #{namespace.gems.join(", ")}, nothing documented in it\n"
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

    def counts(namespaces, path)
      kinds = namespaces.filter_map { |inner, namespace| namespace.kind if inside?(inner, path) }.tally
      kinds["method"] = namespaces[path].methods.size
      NOUNS.filter_map { |noun, plural| "#{kinds[noun]} #{(kinds[noun] == 1) ? noun : plural}" if kinds[noun].to_i.positive? }
    end

    def constant_line(path, value)
      lines = value.lines.size
      (lines > 1) ? "#{path} — #{lines} lines" : "#{path} = #{value}"
    end

    def blocks(indexes, namespace, members, name)
      blocks = indexes.filter_map do |spec, index|
        first, last = index.dig(namespace, members, name, "lines")
        File.readlines(File.join(directory(spec), index.dig(namespace, "page")))[(first - 1)...last].join if first
      end
      blocks.join("\n") unless blocks.empty?
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

      staging = Dir.mktmpdir(".#{name}-", @output)
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
      Dir.mktmpdir(".#{File.basename(target)}-", @output) do |retired|
        File.rename(target, File.join(retired, "docs"))
      rescue Errno::ENOENT
        nil
      end
    end
  end
end
