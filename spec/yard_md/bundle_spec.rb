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
  end
end
