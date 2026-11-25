# frozen_string_literal: true

module YardMd
  # @api private
  class GemDocs
    YARDOC_ARGS = %w[--no-output --no-save --quiet --no-private --hide-api private].freeze
    DIRECTORIES = %w[doc docs examples example samples sample].freeze

    def initialize(spec)
      @spec = spec
    end

    def write(output, log = $stderr)
      output = File.expand_path(output)
      Dir.chdir(source_root) do
        yardoc = parse(log)
        pages(yardoc, output)
        extra_files(yardoc.options.files, output)
      end
      directories(output)
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
      YARD::Registry.clear
      YARD::CLI::Yardoc.new.tap do |yardoc|
        yardoc.parse_arguments(*YARDOC_ARGS, *sources)
        YARD::Logger.instance.show_backtraces = false
        yardoc.run(nil)
      end
    end

    def pages(yardoc, output)
      serializer = YARD::Serializers::FileSystemSerializer.new(basepath: output, extension: "md")
      prose = Prose.new(yardoc.options.markup)
      index = yardoc.options.verifier.run(yardoc.all_objects).to_h do |object|
        page = Page.new(object, yardoc.options.verifier, prose)
        markdown = page.to_s
        next [object.path, {}] unless markdown

        serializer.serialize(object, markdown)
        [object.path, {page: serializer.serialized_path(object), methods: page.spans}]
      end
      File.write(File.join(output, INDEX), JSON.generate(index))
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
