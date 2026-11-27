# frozen_string_literal: true

module YardMd
  # @api private
  class Excerpt
    LINES = 100
    WORDS = 100
    CHARS = 200
    KEPT_WORDS = /\A\s*(?:\S+\s+){#{WORDS - 1}}\S+/
    LONG_WORD = /\S{#{CHARS + 1},}/

    def initialize(text, from = 1)
      @lines = text.lines
      @from = from
    end

    def page(command)
      return if @from > @lines.size

      shown = @lines[@from - 1, LINES]
      last = @from + shown.size - 1
      text = shown.map { |line| cut(line) }.join
      return text if @from == 1 && last == @lines.size

      more = " #{command} --from #{last + 1} for the next." if last < @lines.size
      "#{text.chomp}\n[Showing lines #{@from}–#{last} of #{@lines.size}.#{more}]\n"
    end

    private

    def cut(line)
      text = line.chomp
      count = text.scan(/\S+/).size
      text = "#{text[KEPT_WORDS]} … [+#{count - WORDS} words]" if count > WORDS
      text = text.gsub(LONG_WORD) { |word| "#{word[0, CHARS]}… [+#{word.size - CHARS} chars]" }
      "#{text}#{line[line.chomp.size..]}"
    end
  end
end
