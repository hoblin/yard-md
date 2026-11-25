# frozen_string_literal: true

module YardMd
  # The documentation of every gem the current project's bundle resolves on
  # this platform, written as Markdown into one directory per gem version.
  #
  # The output directory is a cache: a gem whose <tt><gem>-<version></tt> directory
  # exists is skipped unless forced, and a directory appears only once its gem
  # is fully documented, so an interrupted or concurrent run leaves no partial
  # one. Several projects can share it.
  #
  # @example
  #   YardMd::Bundle.new.document
  class Bundle
    # @param output [String] the directory to write into; created when missing
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
    # @raise [Bundler::BundlerError] when the bundle cannot be resolved, e.g.
    #   a gem in it is not installed
    def document
      Bundler.ui = Bundler::UI::Silent.new
      FileUtils.mkdir_p(@output)
      Bundler.definition.specs.map { |spec| build(spec) }.all?
    end

    private

    def build(spec)
      name = "#{spec.name}-#{spec.version}"
      target = File.join(@output, name)
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
      end
    end
  end
end
