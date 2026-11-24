# frozen_string_literal: true

module YardMd
  # The documentation of every gem the current project's bundle resolves on
  # this platform, written as Markdown into one directory per gem version.
  #
  # The output directory is a cache: a gem whose +<gem>-<version>+ directory
  # exists is skipped, and a directory appears only once its gem is fully
  # documented, so an interrupted or concurrent run leaves no partial one.
  # Several projects can share it.
  #
  # @example
  #   YardMd::Bundle.new("~/.cache/gem-docs").document
  class Bundle
    # @param output [String] the directory to write into; created when missing
    def initialize(output)
      @output = File.expand_path(output)
    end

    # Documents each gem not documented yet, printing its +<gem>-<version>+ to
    # stdout. A gem that fails is reported on stderr and skipped; the rest go on.
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
      return true if File.exist?(target)

      staging = Dir.mktmpdir(".#{name}-", @output)
      if write(spec, staging)
        publish(staging, target)
        puts name
        true
      else
        FileUtils.rm_rf(staging)
        false
      end
    end

    def write(spec, staging)
      # YARD's registry, tag library and logger are process-wide, and a gem's
      # .yardopts changes them; a process per gem keeps one gem out of the next.
      pid = fork do
        GemDocs.new(spec.full_gem_path).write(staging)
        exit!(true)
      rescue => error
        warn "yard-md: #{spec.name}-#{spec.version}: #{error.message}"
        exit!(false)
      end
      Process.wait2(pid).last.success?
    end

    def publish(staging, target)
      File.rename(staging, target)
    rescue Errno::EEXIST, Errno::ENOTEMPTY
      FileUtils.rm_rf(staging)
    end
  end
end
