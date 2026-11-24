# frozen_string_literal: true

module YardMd
  # @api private
  class GemDocs
    YARDOC_ARGS = %w[--no-output --no-save --no-stats --quiet --no-private --hide-api private].freeze
    DIRECTORIES = %w[doc docs examples example samples sample].freeze

    def initialize(path)
      @path = path
    end

    def write(output)
      output = File.expand_path(output)
      Dir.chdir(@path) do
        yardoc = parse
        pages(yardoc, output)
        prose(yardoc.options.files, output)
        directories(output)
      end
    end

    private

    def parse
      YARD::Config.options[:safe_mode] = true
      YARD::Logger.instance.io = $stderr
      YARD::Registry.clear
      YARD::CLI::Yardoc.new.tap { |yardoc| yardoc.run(*YARDOC_ARGS) }
    end

    def pages(yardoc, output)
      serializer = YARD::Serializers::FileSystemSerializer.new(basepath: output, extension: "md")
      prose = Prose.new(yardoc.options.markup)
      yardoc.options.verifier.run(yardoc.all_objects).each do |object|
        page = Page.new(object, yardoc.options.verifier, prose).to_s
        serializer.serialize(object, page) if page
      end
    end

    def prose(files, output)
      files.map(&:filename).uniq.each do |file|
        FileUtils.mkdir_p(File.join(output, File.dirname(file)))
        FileUtils.cp(file, File.join(output, file))
      end
    end

    def directories(output)
      DIRECTORIES.select { |directory| File.directory?(directory) }.each do |directory|
        FileUtils.cp_r(directory, output)
      end
    end
  end
end
