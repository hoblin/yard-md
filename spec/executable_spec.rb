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

  def yard_md(*args)
    Bundler.with_unbundled_env do
      Open3.capture3(RbConfig.ruby, *load_path, File.join(root, "exe/yard-md"), *args, chdir: @project)
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

  it "asks for the output directory" do
    _, err, status = yard_md

    expect(status).not_to be_success
    expect(err).to eq("usage: yard-md <output dir>\n")
  end
end
