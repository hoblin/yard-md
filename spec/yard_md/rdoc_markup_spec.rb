# frozen_string_literal: true

RSpec.describe YardMd::RDocMarkup do
  def convert(text, level = 1)
    described_class.new(text, level).to_markdown
  end

  describe "#to_markdown" do
    it "turns +word+, <tt> and <code> into code" do
      expect(convert("Call +save+, <tt>save!</tt> or <code>valid?</code>.")).to eq("Call `save`, `save!` or `valid?`.")
    end

    it "keeps a teletype span that wraps across lines" do
      expect(convert("like <tt>name =\n'Jamie'</tt>, sanitized")).to eq("like `name = 'Jamie'`, sanitized")
    end

    it "leaves pluses that are not around a word" do
      expect(convert("1 + 2 + 3 and a+b+c and +two words+")).to eq("1 + 2 + 3 and a+b+c and +two words+")
    end

    it "turns *bold*, <b>, _em_, <em> and <i> into Markdown emphasis" do
      expect(convert("*bold* <b>also bold</b> _em_ <em>em too</em> <i>it</i>"))
        .to eq("**bold** **also bold** *em* *em too* *it*")
    end

    it "turns an HTML emphasis tag around code into Markdown" do
      expect(convert("<b>Argument +command_line+</b>")).to eq("**Argument `command_line`**")
    end

    it "keeps an indented list as a list, not code" do
      expect(convert("Implement:\n  * <tt>url_for</tt>: a path\n  * <tt>params</tt>: the query"))
        .to eq("Implement:\n  * `url_for`: a path\n  * `params`: the query")
    end

    it "leaves snake_case names and splats alone" do
      expect(convert("find_by_name(*args)")).to eq("find_by_name(*args)")
    end

    it "does not apply emphasis inside code" do
      expect(convert("+_private_+ and <tt>*splat*</tt>")).to eq("`_private_` and `*splat*`")
    end

    it "shifts headings below the given level" do
      expect(convert("= Title\n== Section", 3)).to eq("#### Title\n##### Section")
    end

    it "caps heading depth at six" do
      expect(convert("==== Deep", 3)).to eq("###### Deep")
    end

    it "turns labelled lists into bold terms" do
      expect(convert("[+:name+] the name\nsize:: the size")).to eq("**`:name`** — the name\n**size** — the size")
    end

    it "keeps an indented label description as prose, not code" do
      expect(convert("[term]\n  Described here.\n\n  And here, <tt>too</tt>."))
        .to eq("**term**\n  Described here.\n\n  And here, `too`.")
    end

    it "fences indented verbatim text, unchanged" do
      expect(convert("Example:\n\n  Person.find(+1+, *args)\n\n  # _done_\nAfter."))
        .to eq("Example:\n\n```\nPerson.find(+1+, *args)\n\n# _done_\n```\nAfter.")
    end

    it "fences verbatim text that follows a heading" do
      expect(convert("== Usage\n  Widget.new")).to eq("### Usage\n```\nWidget.new\n```")
    end

    it "keeps a line of spaces as a blank line, not code" do
      expect(convert("First.\n   \nSecond.")).to eq("First.\n   \nSecond.")
    end

    it "keeps list item continuations as prose" do
      expect(convert("* first +item+\n  continued")).to eq("* first `item`\n  continued")
    end

    it "leaves fenced code untouched" do
      expect(convert("```\n+x+ *y*\n```")).to eq("```\n+x+ *y*\n```")
    end

    it "turns RDoc links into Markdown links, and leaves cross-references whole for the prose to reduce to their text" do
      expect(convert("{the guide}[https://guides.rubyonrails.org], {find}[rdoc-ref:FinderMethods#find] and find[rdoc-ref:FinderMethods#find]"))
        .to eq("[the guide](https://guides.rubyonrails.org), {find}[rdoc-ref:FinderMethods#find] and find[rdoc-ref:FinderMethods#find]")
    end

    it "drops the backslash that stops RDoc from cross-referencing" do
      expect(convert("Nested \\Associations")).to eq("Nested Associations")
    end
  end
end
