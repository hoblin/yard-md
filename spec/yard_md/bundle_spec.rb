# frozen_string_literal: true

RSpec.describe YardMd::Bundle do
  subject(:bundle) { described_class.new(@output) }

  let(:sample) { double(name: "sample", version: "0.1.0", full_gem_path: File.expand_path("../fixtures/sample", __dir__)) }
  let(:missing) { double(name: "missing", version: "1.0.0", full_gem_path: "/nonexistent/missing-1.0.0") }

  before do
    @output = Dir.mktmpdir
    allow(Bundler).to receive(:definition).and_return(double(specs: [missing, sample]))
  end

  after { FileUtils.rm_rf(@output) }

  describe "#document" do
    it "documents the gems it can, reports the ones it cannot, and leaves no partial directory behind" do
      result = nil

      expect { result = bundle.document }
        .to output("sample-0.1.0\n").to_stdout
        .and output(/yard-md: missing-1\.0\.0: .*No such file or directory/).to_stderr_from_any_process

      expect(result).to be(false)
      expect(Dir.children(@output)).to eq(["sample-0.1.0"])
    end

    it "skips a gem whose directory already exists" do
      FileUtils.mkdir_p(File.join(@output, "sample-0.1.0"))
      allow(Bundler).to receive(:definition).and_return(double(specs: [sample]))

      expect { expect(bundle.document).to be(true) }.not_to output.to_stdout
      expect(Dir.empty?(File.join(@output, "sample-0.1.0"))).to be(true)
    end
  end
end
