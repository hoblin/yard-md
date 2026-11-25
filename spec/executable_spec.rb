# frozen_string_literal: true

RSpec.describe "exe/yard-md" do
  include_context "with the fixture project"

  let(:output) { File.join(@project, "docs") }

  def yard_md(...)
    run("yard-md", ...)
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
    expect(File.join(@home, "xdg")).not_to satisfy { |cache| File.exist?(cache) }
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

  it "says what it does, takes and writes on --help and -h, and runs nothing, in a project or outside one" do
    [@project, File.dirname(@project)].product(%w[--help -h]).each do |dir, flag|
      out, err, status = nil

      expect { out, err, status = yard_md(flag, chdir: dir) }.not_to change { Dir.children(dir) }, "#{flag} in #{dir}"
      expect(status).to be_success, "#{flag} in #{dir}: #{err}"
      expect(out).to start_with("Usage: yard-md [output dir]\n")
        .and include("<output dir>/<gem>-<version>/", ".yardopts", "skipped", "stderr", "exit status", "--version")
        .and include("here, #{@home}/xdg/gem-docs.")
    end
  end

  describe "with no output directory" do
    it "writes to gem-docs/ in XDG_CACHE_HOME" do
      out, err, status = yard_md

      expect(status).to be_success, err
      expect(out.lines(chomp: true)).to include("sample-0.1.0")
      expect(Dir.children(File.join(@home, "xdg/gem-docs"))).to include("sample-0.1.0")
    end

    it "writes to ~/.cache/gem-docs/ when XDG_CACHE_HOME is unset, empty or relative" do
      [nil, "", "relative"].each do |xdg|
        _, err, status = yard_md(env: {"XDG_CACHE_HOME" => xdg, "HOME" => @home})

        expect(status).to be_success, "#{xdg.inspect}: #{err}"
        expect(Dir.children(File.join(@home, ".cache/gem-docs"))).to include("sample-0.1.0")
        expect(Dir.children(@project)).to eq(["Gemfile"])
      end
    end
  end

  it "prints its version" do
    out, _, status = yard_md("--version")

    expect(status).to be_success
    expect(out).to eq("yard-md #{YardMd::VERSION}\n")
  end

  it "rejects an unknown option rather than taking it for the output directory" do
    _, err, status = nil

    expect { _, err, status = yard_md("-x") }.not_to change { Dir.children(@project) }
    expect(status).not_to be_success
    expect(err).to eq("yard-md: invalid option: -x\n")
  end

  it "answers more than one argument with its help, and runs nothing" do
    out, err, status = nil

    expect { out, err, status = yard_md("one", "two") }.not_to change { Dir.glob("**/*", base: @home) }
    expect(status).not_to be_success
    expect(out).to be_empty
    expect(err).to start_with("Usage: yard-md [output dir]\n")
  end
end
