# frozen_string_literal: true

module YardMd
  # @api private
  class Prose
    DIRECTIVE = /^[ \t]*:(?:markup|include|nodoc|doc|stopdoc|startdoc|enddoc|title|section|category):.*(?:\n|\z)/
    FILE_MARKUP = /^\s*#\s*:markup:\s*(\w+)/
    LINK = /(\\|!)?\{(?!\})(\S+?)(?:\s([^}]*?\S))?\}/
    URL = %r{\A(?:\w+://|mailto:)}

    def self.outside_code(text)
      text.split(/(`[^`]*`)/).map.with_index { |part, index| index.odd? ? part : yield(part) }.join
    end

    def self.substitute(text, rules)
      rules.inject(text) { |result, (pattern, replacement)| result.gsub(pattern, replacement) }
    end

    def initialize(markup)
      @markup = markup.to_sym
      @file_markups = {}
    end

    def call(text, object, level)
      text = text.gsub(DIRECTIVE, "")
      text = RDocMarkup.new(text, level).to_markdown if markup(object.file) == :rdoc
      inline(text)
    end

    def link(name, title = nil)
      case name
      when URL then title ? "[#{title}](#{name})" : name
      when /\Afile:(.+)/ then title || $1
      else title || "`#{name}`"
      end
    end

    private

    def markup(file)
      return @markup unless file && File.file?(file)

      @file_markups.fetch(file) do
        @file_markups[file] = File.read(file, encoding: Encoding::BINARY)[FILE_MARKUP, 1]&.downcase&.to_sym || @markup
      end
    end

    def inline(text)
      fenced = false
      text.lines.map do |line|
        if line.start_with?("```")
          fenced = !fenced
          next line
        end
        next line if fenced || line.start_with?("    ", "\t")

        html = Prose.substitute(line.gsub(RDocMarkup::TELETYPE, "`\\2`"), RDocMarkup::TAGS)
        Prose.outside_code(html) do |part|
          part.gsub(LINK) { ($1) ? $~[0][1..] : link($2, $3) }
        end
      end.join
    end
  end
end
