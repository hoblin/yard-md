# frozen_string_literal: true

module YardMd
  # @api private
  class RDocMarkup
    TELETYPE = %r{<(tt|code)>(.*?)</\1>}
    WRAPPED_TAG = %r{<(tt|code|b|em|i)>[^<\n]*\n[^<]*?</\1>}
    PLUS = /(?<![\w+])\+([^\s+]+)\+(?![\w+])/
    LIST_ITEM = /\A(\s*)([*-]|\d+\.|[a-z]\.)\s+/

    EMPHASIS = [
      [/(?<![\w*])\*([^\s*]+)\*(?![\w*])/, "**\\1**"],
      [/(?<![\w_])_([^\s_](?:\S*[^\s_])?)_(?!\w)/, "*\\1*"],
      [/\{([^{}]+)\}\[rdoc-ref:[^\]]+\]/, "\\1"],
      [/\{([^{}]+)\}\[((?:https?|mailto|ftp):[^\]]+)\]/, "[\\1](\\2)"],
      [/(\w+)\[((?:https?|mailto|ftp):[^\]]+)\]/, "[\\1](\\2)"],
      [/rdoc-ref:(\S+)/, "`\\1`"],
      [/\\(?=[A-Z#:+*_<])/, ""]
    ].freeze

    TAGS = [
      [%r{<b>(.*?)</b>}, "**\\1**"],
      [%r{<(em|i)>(.*?)</\1>}, "*\\2*"]
    ].freeze

    def initialize(text, level)
      @lines = text.gsub(WRAPPED_TAG) { $&.tr("\n", " ") }.lines(chomp: true)
      @level = level
      @output = []
      @margin = 0
    end

    def to_markdown
      until @lines.empty?
        line = @lines.first
        if line.start_with?("```")
          fence
        elsif indent(line) > @margin && !line.strip.empty? && !line.match?(LIST_ITEM)
          verbatim
        else
          @output << paragraph(@lines.shift)
        end
      end
      @output.join("\n")
    end

    private

    def fence
      @output << @lines.shift
      @output << @lines.shift until @lines.empty? || @lines.first.start_with?("```")
      @output << @lines.shift unless @lines.empty?
    end

    def verbatim
      block = []
      block << @lines.shift while @lines.any? && (@lines.first.strip.empty? || indent(@lines.first) > @margin)
      @lines.unshift(block.pop) while block.last.strip.empty?
      depth = block.reject { |line| line.strip.empty? }.map { |line| indent(line) }.min
      @output << "```" << block.map { |line| line[depth..].to_s } << "```"
      @output.flatten!
    end

    def paragraph(line)
      @margin = 0 if line.start_with?(/\S/)
      case line
      when /\A(=+)\s*(.*)\z/
        "#{"#" * [@level + $1.size, 6].min} #{inline($2)}"
      when /\A\[([^\]]+)\](?:\s+(.*))?\z/, /\A([^\s:][^:]*?)::(?:\s+(.*))?\z/
        @margin = indent(@lines.find { |next_line| !next_line.strip.empty? }.to_s)
        ["**#{inline($1)}**", (inline($2) if $2)].compact.join(" — ")
      when LIST_ITEM
        @margin = $~[0].size
        inline(line)
      else
        inline(line)
      end
    end

    def inline(text)
      text = Prose.outside_code(text.gsub(TELETYPE, "`\\2`")) { |part| part.gsub(PLUS, "`\\1`") }
      text = Prose.outside_code(text) { |part| Prose.substitute(part, EMPHASIS) }
      Prose.substitute(text, TAGS)
    end

    def indent(line)
      line[/\A */].size
    end
  end
end
