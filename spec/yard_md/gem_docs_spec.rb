# frozen_string_literal: true

RSpec.describe YardMd::GemDocs do
  fixture = File.expand_path("../fixtures/sample", __dir__)

  before(:context) do
    @output = Dir.mktmpdir
    spec = Gem::Specification.load(File.join(fixture, "sample.gemspec"))
    spec.full_gem_path = fixture
    described_class.new(spec).write(@output)
  end

  after(:context) { FileUtils.rm_rf(@output) }

  def page(path)
    File.read(File.join(@output, path))
  end

  def index
    JSON.parse(page(YardMd::INDEX))
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
      expect(page("Sample.md")).to include(<<~'MARKDOWN')
        ## Sample

        A gem documented in RDoc markup: `code`, `teletype`, **bold** and *emphasis*.

        ### Usage

        Build a widget:

        ```
        widget = Sample::Widget.new(:blue)
        widget.paint(+1+, *args)
        Sample.where(name: {first: 1}).each {|x| "<b>#{x}</b>" }
        ```

        **color** — the widget's color
        **size** — the widget's size

        Set with `SET client_encoding TO <encoding>`. See the readme, {literal} and `Sample::Widget`.
      MARKDOWN
    end

    it "leaves a docstring from a file in Markdown markup as it is, but for its HTML" do
      expect(page("Sample/Notes.md")).to include(<<~MARKDOWN)
        Notes written in Markdown: +literal+ and *emphasis* stay as they are,
        while `HTML` **tags** become Markdown.

            indented {code}

        * a list item with its own code:

          ```ruby
          options = {count: 2}
          ```

        ~~~yaml
        :title: {Thing} <b>kept</b>
        ~~~
      MARKDOWN
    end

    it "drops RDoc directives from prose" do
      expect(page("Sample/Notes.md")).not_to include(":markup:")
    end
    it "heads a page without the implicit Object superclass" do
      expect(page("Sample/Empty/Inner.md")).to start_with("# class Sample::Empty::Inner\n")
    end

    it "lists constants with their values" do
      expect(page("Sample.md")).to include("### LIMITS\n\n```ruby\nLIMITS = {\n  min: 1,\n  max: 10\n}.freeze\n```")
        .and include("### VERSION = \"0.1.0\"")
    end

    it "lists attributes once, with their access and public aliases" do
      expect(page("Sample/Widget.md")).to include(<<~MARKDOWN)
        ## Instance attributes

        ### #color

        Returns: `Symbol` — the widget's color

        Also known as: `hue`

        ### #finish (write-only)

        Sets the finish.

        ### #size (read-only)

        The widget's size.

        ## Class methods
      MARKDOWN
      expect(page("Sample/Widget.md")).not_to match(/### #(color|finish|size)\b.*\n(?m:.*)### #\1\b/)
    end

    it "omits a void return" do
      expect(page("Sample/Widget.md")).to include("### #forget\n\nForgets the widget.\n\n### #initialize")
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

    it "indexes each class and module with its page, a namespace that documents nothing without one" do
      expect(index.transform_values { |entry| entry["page"] }).to eq(
        "" => nil, "Sample" => "Sample.md", "Sample::Empty" => nil, "Sample::Empty::Inner" => "Sample/Empty/Inner.md",
        "Sample::Notes" => "Sample/Notes.md", "Sample::Widget" => "Sample/Widget.md"
      )
    end

    it "indexes the lines of every block a method has on its page" do
      widget = page("Sample/Widget.md").lines

      blocks = index.dig("Sample::Widget", "methods").transform_values { |first, last| widget[(first - 1)..(last - 1)].join }

      expect(blocks).to include(
        "#initialize" => "### #initialize(color)\n\nCreates a widget.\n\nParameters:\n- `color` (`Symbol`) — the color\n",
        "#size" => "### #size (read-only)\n\nThe widget's size.\n",
        ".find" => "### .find(color)\n\nFinds a widget by color.\n\nDeprecated: Use `.where` instead.\n"
      )
      expect(blocks["#paint"]).to start_with("### #paint(").and end_with("Also known as: `repaint`\n")
      expect(blocks.values).to all(start_with("### ").and(end_with("\n")).and(satisfy { |block| !block.end_with?("\n\n") }))
    end

    it "leaves out the API that is not public" do
      expect(page("Sample/Widget.md")).not_to match(/internal|hidden|compare|secret|daub|repaint\(/)
      expect(written).not_to include("Sample/Internal.md")
    end
  end

  context "when the output lies inside one of the gem's own directories" do
    let(:gem_root) { Dir.mktmpdir }
    let(:spec) { instance_double(Gem::Specification, default_gem?: false, full_gem_path: gem_root) }

    before do
      FileUtils.mkdir_p(File.join(gem_root, "lib"))
      File.write(File.join(gem_root, "lib/own.rb"), "# Its own docs.\nmodule Own; end\n")
      FileUtils.mkdir_p(File.join(gem_root, "doc/.own-1.0.0-staging"))
    end

    after { FileUtils.rm_rf(gem_root) }

    it "documents the gem without copying that directory into itself" do
      output = File.join(gem_root, "doc/.own-1.0.0-staging")

      described_class.new(spec).write(output)

      expect(Dir.children(output)).to contain_exactly("Own.md", YardMd::INDEX)
    end
  end

  context "when YARD cannot process some of a gem's code" do
    let(:output) { Dir.mktmpdir }
    let(:spec) { instance_double(Gem::Specification, default_gem?: false, full_gem_path: File.expand_path("../fixtures/broken", __dir__)) }

    after { FileUtils.rm_rf(output) }

    it "documents the rest and logs that code to the given log, without the stack trace" do
      log = StringIO.new

      described_class.new(spec).write(output, log)

      expect(log.string).to eq(<<~LOG)
        [error]: Unhandled exception in YARD::Handlers::Ruby::MixinHandler:
          in `lib/broken.rb`:9:

        \t9: Broken::Alias.include Broken::Mixin

      LOG
      expect(Dir.children(output)).to contain_exactly("Broken.md", YardMd::INDEX)
    end
  end

  context "with a default gem, whose code lives in Ruby's own library directory" do
    let(:output) { Dir.mktmpdir }
    let(:spec) { instance_double(Gem::Specification, default_gem?: true, full_gem_path: "/nonexistent", files: ["exe/sample", "lib/sample.rb"]) }

    before { stub_const("RbConfig::CONFIG", RbConfig::CONFIG.merge("rubylibdir" => File.join(fixture, "lib"))) }

    after { FileUtils.rm_rf(output) }

    it "documents the gem's own files there" do
      described_class.new(spec).write(output)

      expect(Dir.glob("**/*.md", base: output)).to contain_exactly("Sample.md", "Sample/Empty/Inner.md", "Sample/Widget.md")
    end
  end
end
