# frozen_string_literal: true

RSpec.describe YardMd::Bundle do
  subject(:bundle) { described_class.new(cache) }

  let(:cache) { Dir.mktmpdir }
  let(:sample) { gem_spec("sample", "0.1.0", File.expand_path("../fixtures/sample", __dir__)) }
  let(:specs) { [sample] }

  before { allow(Bundler).to receive(:definition).and_return(instance_double(Bundler::Definition, specs: specs)) }

  after { FileUtils.rm_rf(cache) }

  def gem_spec(name, version, path)
    instance_double(Gem::Specification, name: name, version: version, full_gem_path: path, default_gem?: false)
  end

  def widget_page
    File.read(File.join(cache, "sample-0.1.0/Sample/Widget.md"))
  end

  describe "#document" do
    context "when a gem cannot be documented" do
      let(:specs) { [gem_spec("missing", "1.0.0", "/nonexistent/missing-1.0.0"), sample] }

      it "documents the others, reports it, and leaves no partial directory behind" do
        result = nil

        expect { result = bundle.document }
          .to output("sample-0.1.0\n").to_stdout
          .and output(/yard-md: missing-1\.0\.0: Errno::ENOENT: .*No such file or directory/).to_stderr_from_any_process

        expect(result).to be(false)
        expect(Dir.children(cache)).to eq(["sample-0.1.0"])
      end
    end

    context "when YARD cannot process some of a gem's code" do
      let(:specs) { [gem_spec("broken", "1.0.0", File.expand_path("../fixtures/broken", __dir__))] }

      it "documents the gem and reports that code under its name" do
        result = nil

        expect { result = bundle.document }
          .to output("broken-1.0.0\n").to_stdout
          .and output(/\Ayard-md: broken-1\.0\.0:\n\[error\]: Unhandled exception in YARD::Handlers::Ruby::MixinHandler:/).to_stderr_from_any_process

        expect(result).to be(true)
      end

      it "reports that code with the failure when the gem then cannot be documented" do
        allow(YardMd::Page).to receive(:new).and_raise("unrenderable")

        expect { expect(bundle.document).to be(false) }
          .to output(/\Ayard-md: broken-1\.0\.0: RuntimeError: unrenderable\n\[error\]: Unhandled exception in YARD::Handlers::Ruby::MixinHandler:/).to_stderr_from_any_process
      end
    end

    context "when a gem's .yardopts changes YARD's settings" do
      let(:specs) { [gem_spec("terse", "1.0.0", File.expand_path("../fixtures/terse", __dir__)), sample] }

      it "keeps them out of the next gem's pages" do
        expect { bundle.document }.to output.to_stdout

        expect(File.read(File.join(cache, "terse-1.0.0/Terse.md"))).not_to include("Parameters:")
        expect(widget_page).to include("Parameters:\n- `color` (`Symbol`) — the new color")
      end
    end

    it "skips a gem whose directory already exists" do
      FileUtils.mkdir_p(File.join(cache, "sample-0.1.0"))

      expect { expect(bundle.document).to be(true) }.not_to output.to_stdout
      expect(Dir.empty?(File.join(cache, "sample-0.1.0"))).to be(true)
    end

    it "leaves the directory a concurrent run published, and no staging of its own" do
      allow(File).to receive(:rename).and_wrap_original do |rename, staging, target|
        FileUtils.mkdir_p(File.join(target, "theirs"))
        rename.call(staging, target)
      end

      expect { bundle.document }.to output.to_stdout

      expect(Dir.children(cache)).to eq(["sample-0.1.0"])
      expect(Dir.children(File.join(cache, "sample-0.1.0"))).to eq(["theirs"])
    end

    context "with force" do
      subject(:bundle) { described_class.new(cache, force: true) }

      before do
        FileUtils.mkdir_p(File.join(cache, "sample-0.1.0"))
        FileUtils.touch(File.join(cache, "sample-0.1.0/stale.md"))
        FileUtils.mkdir_p(File.join(cache, "other-1.0.0"))
      end

      it "replaces a gem's existing directory and leaves gems outside the bundle alone" do
        expect { expect(bundle.document).to be(true) }.to output("sample-0.1.0\n").to_stdout

        expect(Dir.children(File.join(cache, "sample-0.1.0"))).not_to include("stale.md")
        expect(widget_page).to start_with("# class Sample::Widget")
        expect(Dir.children(cache)).to contain_exactly("sample-0.1.0", "other-1.0.0")
      end

      it "keeps a gem's existing directory when it cannot be rebuilt" do
        allow(YardMd::GemDocs).to receive(:new).and_raise("unreadable")

        expect { expect(bundle.document).to be(false) }.to output(/unreadable/).to_stderr_from_any_process

        expect(Dir.children(File.join(cache, "sample-0.1.0"))).to eq(["stale.md"])
        expect(Dir.children(cache)).to contain_exactly("sample-0.1.0", "other-1.0.0")
      end
    end
  end

  describe "#read" do
    let(:specs) { [sample, gem_spec("addon", "1.0.0", File.expand_path("../fixtures/addon", __dir__))] }

    before { expect { bundle.document }.to output.to_stdout }

    it "lists a namespace's classes and modules from every gem that adds to it, each once" do
      expect(bundle.read("Sample")).to eq("Sample::Empty\nSample::Gadget\nSample::Notes\nSample::Widget\n")
    end

    it "lists a class's methods, attribute accessors and aliases in the order of its pages, each once" do
      expect(bundle.read("Sample::Widget").lines(chomp: true)).to eq(%w[
        #color #color= #hue #finish= #size .find #forget #initialize #paint #repaint #resize .paint #polish
      ])
    end

    it "answers a method with its block of the page and nothing else" do
      expect(bundle.read("Sample::Widget.find")).to eq("### .find(color)\n\nFinds a widget by color.\n\nDeprecated: Use `.where` instead.\n")
      expect(bundle.read("Sample::Widget#forget")).to eq("### #forget\n\nForgets the widget.\n")
    end

    it "answers a method with the block from every gem that documents it" do
      expect(bundle.read("Sample::Widget#paint")).to start_with("### #paint(color, options = {})")
        .and end_with("Also known as: `repaint`\n\n### #paint\n\nPaints the widget again.\n")
    end

    it "tells a class method from an instance method of the same name" do
      expect(bundle.read("Sample::Widget.paint")).to eq("### .paint\n\nPaints every widget.\n")
    end

    it "answers an alias with the block it belongs to" do
      expect(bundle.read("Sample::Widget#repaint")).to start_with("### #paint(color, options = {})").and end_with("Also known as: `repaint`\n")
      expect(bundle.read("Sample::Widget#hue")).to eq(bundle.read("Sample::Widget#color=")).and start_with("### #color\n")
    end

    it "answers for a core class a gem reopens" do
      expect(bundle.read("String")).to eq("#squish\n")
      expect(bundle.read("String#squish")).to eq("### #squish\n\nSqueezes the string's whitespace.\n")
    end

    it "answers for the top-level namespace when the constant is left out" do
      expect(bundle.read("")).to eq("Sample\nString\n#tidy\n")
      expect(bundle.read("#tidy")).to eq("### #tidy\n\nTidies everything up.\n")
    end

    it "answers nothing for what no gem documents" do
      expect([bundle.read("Absent"), bundle.read("Sample::Widget#absent"), bundle.read("Absent#paint")]).to all(be_nil)
    end

    it "answers from the other gems when one has no index or no directory" do
      FileUtils.mkdir_p(File.join(cache, "stale-1.0.0"))
      allow(Bundler).to receive(:definition).and_return(instance_double(Bundler::Definition, specs: [
        gem_spec("stale", "1.0.0", "/nonexistent"), gem_spec("absent", "1.0.0", "/nonexistent"), *specs
      ]))

      expect(bundle.read("Sample::Widget#forget")).to eq("### #forget\n\nForgets the widget.\n")
    end

    it "reads only the versions the bundle resolves" do
      FileUtils.mkdir_p(File.join(cache, "sample-9.9.9"))
      File.write(File.join(cache, "sample-9.9.9", YardMd::INDEX), JSON.generate("Sample::Future" => {}))

      expect(bundle.read("Sample")).not_to include("Sample::Future")
    end
  end
end
