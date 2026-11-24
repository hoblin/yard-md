# frozen_string_literal: true

require "open3"

RSpec.describe "exe/yard-md" do
  let(:root) { File.expand_path("..", __dir__) }
  let(:load_path) { [File.join(root, "lib"), *Gem.loaded_specs["yard"].full_require_paths].map { |path| "-I#{path}" } }
  let(:output) { File.join(@project, "docs") }

  around do |example|
    Dir.mktmpdir do |dir|
      FileUtils.cp_r(Dir.glob(File.join(root, "spec/fixtures/*")), dir)
      @project = File.join(dir, "project")
      example.run
    end
  end

  def yard_md(*args, chdir: @project)
    Bundler.with_unbundled_env do
      Open3.capture3(RbConfig.ruby, *load_path, File.join(root, "exe/yard-md"), *args, chdir: chdir)
    end
  end

  def snapshot
    Dir.glob("**/*", File::FNM_DOTMATCH, base: output).to_h { |path| [path, File.mtime(File.join(output, path))] }
  end

  it "documents every gem the bundle resolves into its own directory" do
    out, err, status = yard_md("docs")

    expect(status).to be_success, err
    expect(out.lines(chomp: true)).to contain_exactly("sample-0.1.0", "bundler-#{Bundler::VERSION}")
    expect(Dir.children(output)).to contain_exactly("sample-0.1.0", "bundler-#{Bundler::VERSION}")
    expect(File.read(File.join(output, "sample-0.1.0/Sample/Widget.md"))).to start_with("# class Sample::Widget")
    expect(File.join(output, "bundler-#{Bundler::VERSION}/Bundler.md")).to satisfy { |page| File.file?(page) }
  end

  it "writes nothing on a second run" do
    yard_md("docs")
    before = snapshot

    out, _, status = yard_md("docs")

    expect(status).to be_success
    expect(out).to be_empty
    expect(snapshot).to eq(before)
  end

  it "says in one line why a bundle it cannot resolve stops it" do
    File.write(File.join(@project, "Gemfile"), %(gem "absent", path: "../absent"\n))

    _, err, status = yard_md("docs")

    expect(status).not_to be_success
    expect(err.lines.size).to eq(1)
    expect(err).to start_with("yard-md: ").and include("absent")
  end

  describe "--help" do
    it "says what it does, takes and writes, and exits without running, even outside a project" do
      outside = File.dirname(@project)

      %w[--help -h].each do |flag|
        out, err, status = yard_md(flag, chdir: outside)

        expect(status).to be_success, err
        expect(out).to start_with("Usage: yard-md <output dir>\n")
          .and include("<output dir>/<gem>-<version>/", ".yardopts", "skipped", "stderr", "exit status")
        expect(Dir.children(outside)).to contain_exactly("project", "sample", "terse")
      end
    end
  end

  it "prints its version" do
    out, _, status = yard_md("--version")

    expect(status).to be_success
    expect(out).to eq("yard-md #{YardMd::VERSION}\n")
  end

  it "rejects an unknown option rather than taking it for the output directory" do
    _, err, status = yard_md("-x")

    expect(status).not_to be_success
    expect(err).to eq("yard-md: invalid option: -x\n")
    expect(Dir.children(@project)).to eq(["Gemfile"])
  end

  it "answers a wrong number of arguments with its help" do
    [[], %w[one two]].each do |args|
      _, err, status = yard_md(*args)

      expect(status).not_to be_success
      expect(err).to start_with("Usage: yard-md <output dir>\n")
    end
  end
end
