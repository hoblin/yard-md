# frozen_string_literal: true

RSpec.describe YardMd::Bundle do
  subject(:bundle) { described_class.new(cache) }

  let(:cache) { Dir.mktmpdir }
  let(:sample) { gem_spec("sample", "0.1.0", File.expand_path("../fixtures/sample", __dir__)) }
  let(:specs) { [sample] }

  before { resolve(specs) }

  after { FileUtils.rm_rf(cache) }

  def gem_spec(name, version, path)
    {name: name, version: version, path: path}
  end

  def answering(result, err = "")
    proc do |*args|
      File.write(args.last, JSON.generate(result)) if result
      ["", err, nil]
    end
  end

  def resolve(specs)
    allow(Open3).to receive(:capture3, &answering(specs: specs))
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

      it "publishes its rebuild when a concurrent run retired the directory first" do
        allow(File).to receive(:rename).and_wrap_original do |rename, from, to|
          FileUtils.rm_rf(from) if from.end_with?("sample-0.1.0")
          rename.call(from, to)
        end

        expect { expect(bundle.document).to be(true) }.to output("sample-0.1.0\n").to_stdout

        expect(widget_page).to start_with("# class Sample::Widget")
      end

      it "keeps a gem's existing directory when it cannot be rebuilt" do
        allow(YardMd::GemDocs).to receive(:new).and_raise("unreadable")

        expect { expect(bundle.document).to be(false) }.to output(/unreadable/).to_stderr_from_any_process

        expect(Dir.children(File.join(cache, "sample-0.1.0"))).to eq(["stale.md"])
        expect(Dir.children(cache)).to contain_exactly("sample-0.1.0", "other-1.0.0")
      end
    end
  end

  describe "resolving the bundle" do
    it "asks the project's Ruby through mise where mise is installed, letting mise install nothing" do
      expect(Open3).to receive(:capture3)
        .with({"MISE_EXEC_AUTO_INSTALL" => "false"}, "mise", "exec", "--", "ruby", "-e", described_class::RESOLVER, kind_of(String))
        .and_invoke(answering(specs: [sample]))

      expect { bundle.document }.to output("sample-0.1.0\n").to_stdout
    end

    it "asks the Ruby on the PATH where mise is not installed" do
      expect(Open3).to receive(:capture3).with(anything, "mise", any_args).and_raise(Errno::ENOENT)
      expect(Open3).to receive(:capture3).with("ruby", "-e", described_class::RESOLVER, kind_of(String)).and_invoke(answering(specs: [sample]))

      expect { bundle.document }.to output("sample-0.1.0\n").to_stdout
    end

    it "fails with Bundler's message alone, writing nothing, when the bundle cannot be resolved" do
      allow(Open3).to receive(:capture3, &answering({error: "Could not find absent-1.0.0 in locally installed gems"}, "loading gems\n"))
      FileUtils.rm_rf(cache)

      expect { bundle.document }.to raise_error(YardMd::Error, "Could not find absent-1.0.0 in locally installed gems")
      expect(File.exist?(cache)).to be(false)
    end

    it "fails with what the project's Ruby printed when it gives no answer" do
      allow(Open3).to receive(:capture3, &answering(nil, "mise ERROR ruby is not installed\n"))

      expect { bundle.document }.to raise_error(YardMd::Error, "mise ERROR ruby is not installed")
    end

    it "gives a default gem's Ruby files in its Ruby's own library directory, and nothing else" do
      allow(Open3).to receive(:capture3).and_call_original
      optparse = Gem::Specification.find { |spec| spec.default_gem? && spec.name == "optparse" }
      answer, err = Dir.mktmpdir do |project|
        File.write(File.join(project, "Gemfile"), %(gem "optparse", "#{optparse.version}"\n))
        file = File.join(project, "answer.json")
        _, err, = Bundler.with_unbundled_env { Open3.capture3(RbConfig.ruby, "-e", described_class::RESOLVER, file, chdir: project) }
        [File.exist?(file) && File.read(file), err]
      end
      lib = RbConfig::CONFIG["rubylibdir"]

      expect(answer).to be_truthy, err
      resolved = JSON.parse(answer, symbolize_names: true)[:specs].find { |spec| spec[:name] == "optparse" }
      expect(resolved[:root]).to eq(lib)
      expect(resolved[:files]).to include("optparse.rb", "optparse/time.rb")
        .and all(end_with(".rb").and(satisfy { |file| File.file?(File.join(lib, file)) }))
    end
  end

  describe "#read" do
    let(:specs) { [sample, gem_spec("addon", "1.0.0", File.expand_path("../fixtures/addon", __dir__))] }
    let(:project) { Dir.mktmpdir }
    let(:lockfile) { File.join(project, "Gemfile.lock") }

    around do |example|
      given = ENV["BUNDLE_LOCKFILE"]
      ENV["BUNDLE_LOCKFILE"] = lockfile
      example.run
    ensure
      ENV["BUNDLE_LOCKFILE"] = given
      FileUtils.rm_rf(project)
    end

    before do
      expect { bundle.document }.to output.to_stdout
      lock("addon (1.0.0)", "sample (0.1.0)")
    end

    def lock(*gems, bundled_with: nil)
      File.write(lockfile, <<~LOCK)
        GEM
          specs:
        #{gems.map { |gem| "    #{gem}\n" }.join}
        PLATFORMS
          ruby
        #{"\nBUNDLED WITH\n   #{bundled_with}" if bundled_with}
      LOCK
    end

    it "takes the versions from the lockfile, starting no process" do
      expect(Open3).not_to receive(:capture3)

      expect(bundle.read("Sample::VERSION")).to eq(%(### VERSION = "0.1.0"\n))
    end

    it "reads a gem the lockfile lists for several platforms once" do
      lock("sample (0.1.0)", "sample (0.1.0-x86_64-linux)", "sample (0.1.0-arm64-darwin)")

      expect(bundle.read("Sample::Empty::Inner")).to eq("Sample::Empty::Inner — class in sample 0.1.0, with no constants, classes or methods\n")
      expect(bundle.read("Sample::Widget#forget")).to eq("### #forget\n\nForgets the widget.\n")
    end

    it "reads Bundler at the version the lockfile was bundled with" do
      FileUtils.mkdir_p(File.join(cache, "bundler-9.9.9"))
      File.write(File.join(cache, "bundler-9.9.9", YardMd::INDEX), JSON.generate("" => {kind: "root"}, "Bundler" => {kind: "module"}))
      lock("sample (0.1.0)", bundled_with: "9.9.9")

      expect(bundle.read("Bundler")).to eq("Bundler — module in bundler 9.9.9, with no constants, classes or methods\n")
    end

    it "fails with what it could not read when the project has no lockfile, or a broken one" do
      File.delete(lockfile)
      expect { bundle.read("Sample") }.to raise_error(YardMd::Error, "Could not locate Gemfile.lock")

      File.write(lockfile, "<<<<<<< HEAD\nGEM\n=======\n>>>>>>> branch\n")
      expect { bundle.read("Sample") }.to raise_error(YardMd::Error, /merge conflicts/)
    end

    it "lists a namespace's constants, then its classes and modules from every gem that adds to them, each once with what it holds" do
      expect(bundle.read("Sample")).to eq(<<~LIST)
        Sample::LIMITS — 4 lines
        Sample::VERSION = "0.1.0"
        Sample::Empty — module, 1 class
        Sample::Gadget — class
        Sample::Notes — class
        Sample::Widget — class, 2 constants, 15 methods
      LIST
    end

    it "lists a class's constants, then its methods, attribute accessors and aliases gem by gem in name order, in the order of their pages, each once with its summary" do
      expect(bundle.read("Sample::Widget").lines(chomp: true)).to eq([
        "Sample::Widget::FINISHES — 82 characters", "Sample::Widget::SIZES = %i[small large].freeze",
        ".paint — Paints every widget.", "#buff — Buffs the widget with a matching cloth until it shines.",
        "#paint — Paints the widget again.", "#polish — Polishes the widget.", "#scrub — Scrubs the widget, `force` or not.",
        "#color — The widget's color.", "#color= — The widget's color.", "#hue — The widget's color.",
        "#finish= — Sets the finish.", "#size — The widget's size.", ".find — Finds a widget by color.",
        "#forget — Forgets the widget.", "#initialize — Creates a widget.",
        "#repaint — Paints the widget.", "#resize"
      ])
    end

    it "answers a constant with its block of the page" do
      expect(bundle.read("Sample::VERSION")).to eq(%(### VERSION = "0.1.0"\n))
      expect(bundle.read("Sample::Widget::SIZES")).to eq("### SIZES = %i[small large].freeze\n\nThe sizes a widget comes in.\n")
      expect(bundle.read("ADDON_LOADED")).to eq("### ADDON_LOADED = true\n\nWhether the addon is loaded.\n")
    end

    it "answers a class or module it has nothing to list in with its kind and gem" do
      expect(bundle.read("Sample::Gadget")).to eq("Sample::Gadget — class in addon 1.0.0, with no constants, classes or methods\n")
      expect(bundle.read("Sample::Empty::Inner")).to eq("Sample::Empty::Inner — class in sample 0.1.0, with no constants, classes or methods\n")
    end

    it "answers a method with its block of the page and nothing else" do
      expect(bundle.read("Sample::Widget.find")).to eq("### .find(color)\n\nFinds a widget by color.\n\nDeprecated: Use `.where` instead.\n")
      expect(bundle.read("Sample::Widget#forget")).to eq("### #forget\n\nForgets the widget.\n")
    end

    it "answers a method with the block from every gem that documents it, gem by gem in name order" do
      expect(bundle.read("Sample::Widget#paint")).to start_with("### #paint\n\nPaints the widget again.\n\n### #paint(color, options = {})")
        .and end_with("Also known as: `repaint`\n")
    end

    it "tells a class method from an instance method of the same name" do
      expect(bundle.read("Sample::Widget.paint")).to eq("### .paint\n\nPaints every widget.\n")
    end

    it "answers an alias with the block it belongs to" do
      expect(bundle.read("Sample::Widget#repaint")).to start_with("### #paint(color, options = {})").and end_with("Also known as: `repaint`\n")
      expect(bundle.read("Sample::Widget#hue")).to eq(bundle.read("Sample::Widget#color=")).and start_with("### #color\n")
    end

    it "answers for a core class a gem reopens" do
      expect(bundle.read("String")).to eq("#squish — Squeezes the string's whitespace.\n")
      expect(bundle.read("String#squish")).to eq("### #squish\n\nSqueezes the string's whitespace.\n")
    end

    it "answers for the top-level namespace when the constant is left out" do
      expect(bundle.read("")).to eq(<<~LIST)
        ADDON_LOADED = true
        Sample — module, 2 constants, 1 module, 3 classes
        String — class, 1 method
        #tidy — Tidies everything up.
      LIST
      expect(bundle.read("#tidy")).to eq("### #tidy\n\nTidies everything up.\n")
    end

    it "answers nothing for what no gem documents" do
      expect(%w[Absent Sample::ABSENT Sample::Widget::@@polished Sample::Widget#absent Absent#paint].map { |address| bundle.read(address) }).to all(be_nil)
    end

    it "answers from the other gems when one has no index or no directory" do
      FileUtils.mkdir_p(File.join(cache, "stale-1.0.0"))
      lock("absent (1.0.0)", "addon (1.0.0)", "sample (0.1.0)", "stale (1.0.0)")

      expect(bundle.read("Sample::Widget#forget")).to eq("### #forget\n\nForgets the widget.\n")
    end

    it "answers from the other gems when one was indexed by an earlier yard-md" do
      File.write(File.join(cache, "addon-1.0.0", YardMd::INDEX), JSON.generate("" => {}, "Sample::Widget" => {page: "Sample/Widget.md", methods: {"#polish" => [1, 2]}}))

      expect(bundle.read("Sample::Widget#polish")).to be_nil
      expect(bundle.read("Sample")).to eq(<<~LIST)
        Sample::LIMITS — 4 lines
        Sample::VERSION = "0.1.0"
        Sample::Empty — module, 1 class
        Sample::Notes — class
        Sample::Widget — class, 11 methods
      LIST
    end

    it "reads only the versions the lockfile locks" do
      FileUtils.mkdir_p(File.join(cache, "sample-9.9.9"))
      File.write(File.join(cache, "sample-9.9.9", YardMd::INDEX), JSON.generate("" => {kind: "root"}, "Sample::Future" => {kind: "class"}))

      expect(bundle.read("Sample")).not_to include("Sample::Future")
    end
  end
end
