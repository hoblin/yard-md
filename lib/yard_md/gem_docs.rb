# frozen_string_literal: true

module YardMd
  # @api private
  class GemDocs
    YARDOC_ARGS = %w[--no-output --no-save --quiet --no-private --hide-api private].freeze
    DIRECTORIES = %w[doc docs examples example samples sample].freeze

    def initialize(spec)
      @spec = spec
    end

    def write(output)
      output = File.expand_path(output)
      log = StringIO.new
      Dir.chdir(source_root) do
        yardoc = parse(log)
        pages(yardoc, output)
        extra_files(yardoc.options.files, output)
      end
      directories(output)
      log.string
    end

    private

    def source_root
      @spec.default_gem? ? RbConfig::CONFIG["rubylibdir"] : @spec.full_gem_path
    end

    def sources
      return [] unless @spec.default_gem?

      @spec.files.filter_map { |file| file.delete_prefix("lib/") if file.start_with?("lib/") && file.end_with?(".rb") }
    end

    def parse(log)
      YARD::Config.options[:safe_mode] = true
      YARD::Logger.instance.io = log
      YARD::Logger.instance.show_backtraces = false
      YARD::Registry.clear
      YARD::CLI::Yardoc.new.tap { |yardoc| yardoc.run(*YARDOC_ARGS, *sources) }
    end

    def pages(yardoc, output)
      serializer = YARD::Serializers::FileSystemSerializer.new(basepath: output, extension: "md")
      prose = Prose.new(yardoc.options.markup)
      yardoc.options.verifier.run(yardoc.all_objects).each do |object|
        page = Page.new(object, yardoc.options.verifier, prose).to_s
        serializer.serialize(object, page) if page
      end
    end

    def extra_files(files, output)
      files.map(&:filename).uniq.each do |file|
        FileUtils.mkdir_p(File.join(output, File.dirname(file)))
        FileUtils.cp(file, File.join(output, file))
      end
    end

    def directories(output)
      DIRECTORIES.map { |directory| File.join(@spec.full_gem_path, directory) }.each do |directory|
        FileUtils.cp_r(directory, output) if File.directory?(directory) && !output.start_with?("#{directory}/")
      end
    end
  end
end
