# frozen_string_literal: true

RSpec.describe YardMd::GemDocs do
  fixture = File.expand_path("../fixtures/sample", __dir__)

  before do
    @output = Dir.mktmpdir
    described_class.new(fixture).write(@output)
  end

  after { FileUtils.rm_rf(@output) }

  def page(path)
    File.read(File.join(@output, path))
  end

  def written
    Dir.glob("**/*", base: @output).select { |path| File.file?(File.join(@output, path)) }.sort
  end

  describe "#write" do
    it "writes a page per documented class and module, the README, the .yardopts files and the doc and example directories" do
      expect(written).to eq(%w[
        GUIDE.md README.md Sample.md Sample/Empty/Inner.md Sample/Notes.md Sample/Widget.md
        doc/notes.rdoc examples/basic.rb
      ])
    end

    it "writes no page for a namespace that documents nothing" do
      expect(written).not_to include("Sample/Empty.md")
    end

    it "copies the prose and the directories as they are" do
      expect(File.read(File.join(@output, "doc/notes.rdoc"))).to eq(File.read(File.join(fixture, "doc/notes.rdoc")))
      expect(page("README.md")).to eq(File.read(File.join(fixture, "README.md")))
    end

    it "heads a page with the object's kind, path, superclass, mixins and files" do
      expect(page("Sample/Widget.md")).to start_with(<<~MARKDOWN)
        # class Sample::Widget < Struct
        Includes: `Comparable`
        Extended by: `Enumerable`
        Defined in: `lib/sample.rb`

        A widget with a color.
      MARKDOWN
    end

    it "writes an RDoc docstring as Markdown, its code example unchanged" do
      expect(page("Sample.md")).to include(<<~MARKDOWN)
        ## Sample

        A gem documented in RDoc markup: `code`, `teletype`, **bold** and *emphasis*.

        ### Usage

        Build a widget:

        ```
        widget = Sample::Widget.new(:blue)
        widget.paint(+1+, *args)
        ```

        **color** — the widget's color
        **size** — the widget's size
      MARKDOWN
    end

    it "leaves a docstring from a file in Markdown markup as it is, but for its HTML" do
      expect(page("Sample/Notes.md"))
        .to include("+literal+ and *emphasis* stay as they are,\nwhile `HTML` **tags** become Markdown.\n\n    indented {code}\n")
    end

    it "lists constants with their values" do
      expect(page("Sample.md")).to include("### LIMITS\n\n```ruby\nLIMITS = {\n  min: 1,\n  max: 10\n}.freeze\n```")
        .and include("### VERSION = \"0.1.0\"")
    end

    it "lists attributes once, with their access" do
      expect(page("Sample/Widget.md")).to include(<<~MARKDOWN)
        ## Instance attributes

        ### #color

        Returns: `Symbol` — the widget's color

        ### #size (read-only)

        The widget's size.
      MARKDOWN
    end

    it "writes a method's tags, its block and its aliases" do
      expect(page("Sample/Widget.md")).to include(<<~MARKDOWN)
        ### #paint(color, options = {}) {|previous| ... }

        Paints the widget.

        Example: Paint it red

        ```ruby
        widget.paint(:red) { |previous| puts previous }
        ```

        Parameters:
        - `color` (`Symbol`) — the new color
        - `options` (`Hash`) — painting options

        Options Hash:
        - `options` `:glossy` (`Boolean`, default: `false`) — whether to add gloss

        Yield Parameters:
        - `previous` (`Symbol`) — the color before painting

        Returns: `self`

        Raises: `ArgumentError` — when the color is unknown

        See Also:
        - `Sample::Widget#color`
        - https://example.com/paint — Painting guide

        Also known as: `repaint`
      MARKDOWN
    end

    it "writes each overload with its own docs" do
      expect(page("Sample/Widget.md")).to include(<<~MARKDOWN)
        ### #resize(*args)

        Overload: `resize(size)`

        Sets the size.

        Parameters:
        - `size` (`Integer`) — the size

        Overload: `resize(width, height)`

        Sets width and height.
      MARKDOWN
    end

    it "writes class methods apart, and YARD links as code" do
      expect(page("Sample/Widget.md")).to include("## Class methods\n\n### .find(color)\n\nFinds a widget by color.\n\nDeprecated: Use `.where` instead.")
    end

    it "omits the return a constructor gets from YARD" do
      expect(page("Sample/Widget.md")).to include("### #initialize(color)\n\nCreates a widget.\n\nParameters:\n- `color` (`Symbol`) — the color\n\n### #paint")
    end

    it "leaves out the API that is not public" do
      expect(page("Sample/Widget.md")).not_to match(/internal|hidden|compare|secret|repaint\(/)
      expect(written).not_to include("Sample/Internal.md")
    end
  end
end
