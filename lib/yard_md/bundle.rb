# frozen_string_literal: true

module YardMd
  # The documentation of every gem the current project's bundle resolves on
  # this platform, written as Markdown into one directory per gem version.
  #
  # The output directory is a cache: a gem whose <tt><gem>-<version></tt> directory
  # exists is skipped, and a directory appears only once its gem is fully
  # documented, so an interrupted or concurrent run leaves no partial one.
  # Several projects can share it.
  #
  # @example
  #   YardMd::Bundle.new.document
  #   YardMd::Bundle.new.read("YARD::Registry.at")
  class Bundle
    # @param output [String] the directory to write into, created when missing,
    #   and read from
    def initialize(output = CACHE)
      @output = File.expand_path(output)
    end

    # Documents each gem not documented yet, printing its <tt><gem>-<version></tt> to
    # stdout. A gem that fails is reported on stderr and skipped; the rest go on.
    # The code YARD could not process in a gem is reported on stderr under the
    # gem's name, without YARD's stack traces; the gem still counts as documented.
    #
    # @return [Boolean] whether every gem is documented
    # @raise [Bundler::BundlerError] when the bundle cannot be resolved, e.g.
    #   a gem in it is not installed
    def document
      FileUtils.mkdir_p(@output)
      specs.map { |spec| build(spec) }.all?
    end

    # Answers from the documentation {#document} wrote for the bundle's gems, at
    # the versions it resolves. A gem not documented yet, or documented by
    # yard-md 0.1.0, which wrote no index, does not answer.
    #
    # @param address [String] a constant, or a method of one:
    #   <tt>Faraday</tt>, <tt>Faraday::Connection#get</tt>, <tt>Faraday.new</tt>;
    #   an empty constant is the top-level namespace: <tt>""</tt>, <tt>#puts</tt>
    # @return [String] for a constant, its classes and modules, then its
    #   methods, one per line, from every gem that has them, empty when it has
    #   neither; for a method, its block of the page, from every gem that
    #   documents it
    # @return [nil] when no gem documents it
    # @raise [Bundler::BundlerError] when the bundle cannot be resolved
    def read(address)
      constant, method = address.match(/\A([^#.]*)(.*)\z/m).captures
      indexes = specs.filter_map do |spec|
        directory = directory(spec)
        index = File.join(directory, INDEX)
        [directory, JSON.parse(File.read(index))] if File.exist?(index)
      end
      method.empty? ? listing(indexes, constant) : method_blocks(indexes, constant, method)
    end

    private

    def specs
      Bundler.ui = Bundler::UI::Silent.new
      Bundler.definition.specs
    end

    def directory(spec)
      File.join(@output, "#{spec.name}-#{spec.version}")
    end

    def listing(indexes, constant)
      children = indexes.flat_map { |_, index| index.keys.select { |path| path != constant && path.rpartition("::").first == constant } }
      entries = indexes.filter_map { |_, index| index[constant] }
      return if children.empty? && entries.empty?

      [*children.uniq.sort, *entries.flat_map { |entry| entry.fetch("methods", {}).keys }.uniq].map { |line| "#{line}\n" }.join
    end

    def method_blocks(indexes, constant, method)
      blocks = indexes.filter_map do |directory, index|
        first, last = index.dig(constant, "methods", method)
        File.readlines(File.join(directory, index.dig(constant, "page")))[(first - 1)...last].join if first
      end
      blocks.join("\n") unless blocks.empty?
    end

    def build(spec)
      target = directory(spec)
      name = File.basename(target)
      return true if File.exist?(target)

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
      File.rename(staging, target)
    rescue Errno::EEXIST, Errno::ENOTEMPTY
      nil
    end
  end
end
