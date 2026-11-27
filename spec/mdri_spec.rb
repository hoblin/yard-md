# frozen_string_literal: true

RSpec.describe "exe/mdri" do
  include_context "with the fixture project"

  def mdri(...)
    run("mdri", ...)
  end

  describe "in a project yard-md documented" do
    before { expect(run("yard-md").last).to be_success }

    it "prints a namespace's documentation, then its constants, classes and modules" do
      out, err, status = mdri("Sample")

      expect(status).to be_success, err
      expect(out).to start_with("## Sample\n\nA gem documented in RDoc markup")
        .and end_with(%(\n\nSample::LIMITS — 4 lines\nSample::VERSION = "0.1.0"\nSample::Empty — module, 1 class\nSample::Notes — class\nSample::Widget — class, 11 methods\n))
    end

    it "prints a method's documentation" do
      out, err, status = mdri("Sample::Widget.find")

      expect(status).to be_success, err
      expect(out).to eq("### .find(color)\n\nFinds a widget by color.\n\nDeprecated: Use `.where` instead.\n")
    end

    it "prints a constant's documentation" do
      out, err, status = mdri("Sample::VERSION")

      expect(status).to be_success, err
      expect(out).to eq(%(### VERSION = "0.1.0"\n))
    end

    it "prints the documentation of a class it has nothing to list in, then says, and succeeds, that it exists" do
      out, err, status = mdri("Sample::Notes")

      expect(status).to be_success, err
      expect(out).to start_with("Notes written in Markdown")
        .and end_with("~~~\n\nSample::Notes — class in sample 0.1.0, with no constants, classes or methods\n")
    end

    it "starts the answer at the line --from gives, saying where it is" do
      out, err, status = mdri("--from", "23", "Sample")

      expect(status).to be_success, err
      expect(out).to eq("Sample::Notes — class\nSample::Widget — class, 11 methods\n[Showing lines 23–24 of 24.]\n")
    end

    it "says on stderr that --from starts past the answer" do
      out, err, status = mdri("Sample", "--from", "25")

      expect(status).not_to be_success
      expect(out).to be_empty
      expect(err).to eq("mdri: the answer has 24 lines, fewer than --from 25\n")
    end

    it "says on stderr that nothing documents what it was asked" do
      out, err, status = mdri("Sample::Widget#nope")

      expect(status).not_to be_success
      expect(out).to be_empty
      expect(err).to eq("mdri: nothing in the bundle documents Sample::Widget#nope\n")
    end

    it "says in one line that it cannot read what yard-md wrote" do
      FileUtils.chmod(0o000, File.join(@home, "xdg/gem-docs/sample-0.1.0", YardMd::INDEX))

      _, err, status = mdri("Sample")

      expect(status).not_to be_success
      expect(err.lines.size).to eq(1)
      expect(err).to start_with("mdri: Permission denied")
    end
  end

  it "reads the versions from Gemfile.lock alone, without resolving the Gemfile" do
    expect(run("yard-md").last).to be_success
    File.write(File.join(@project, "Gemfile"), %(gem "absent", path: "../absent"\n))

    out, err, status = mdri("Sample::VERSION")

    expect(status).to be_success, err
    expect(out).to eq(%(### VERSION = "0.1.0"\n))
  end

  it "says in one line that it finds no Gemfile.lock, or no Gemfile" do
    File.delete(File.join(@project, "Gemfile.lock"))

    [[@project, "mdri: Could not locate Gemfile.lock\n"], [File.dirname(@project), "mdri: Could not locate Gemfile\n"]].each do |dir, message|
      out, err, status = mdri("Sample", chdir: dir)

      expect(status).not_to be_success, dir
      expect(out).to be_empty
      expect(err).to eq(message)
    end
  end

  it "prints its version" do
    out, _, status = mdri("--version")

    expect(status).to be_success
    expect(out).to eq("mdri #{YardMd::VERSION}\n")
  end

  it "reads from the directory it is given" do
    run("yard-md", "docs")

    out, err, status = mdri("Sample::Empty", "docs")

    expect(status).to be_success, err
    expect(out).to eq("Sample::Empty::Inner — class\n")
  end

  it "ends an answer longer than 100 lines with a command that reads the next, from the directory it read" do
    output = File.join(@project, "-my docs")
    FileUtils.mkdir_p(File.join(output, "sample-0.1.0"))
    methods = (1..101).to_h { |number| ["#m#{number}", {lines: [1, 1]}] }
    File.write(File.join(output, "sample-0.1.0", YardMd::INDEX), JSON.generate("" => {kind: "root"}, "Sample" => {kind: "module", methods: methods}))

    out, err, status = mdri("Sample", "--", "-my docs")

    expect(status).to be_success, err
    expect(out.lines.size).to eq(101)
    expect(out.lines.last).to eq("[Showing lines 1–100 of 101. #{Shellwords.join(["mdri", "Sample", output])} --from 101 for the next.]\n")

    out, err, status = mdri(*Shellwords.split(out.lines.last[/\. (mdri .*) for the next/, 1]).drop(1), chdir: output)

    expect(status).to be_success, err
    expect(out).to eq("#m101\n[Showing lines 101–101 of 101.]\n")
  end

  it "rejects a --from that is not a line number" do
    %w[0 -1 x].each do |from|
      _, err, status = mdri("Sample", "--from", from)

      expect(status).not_to be_success, from
      expect(err).to eq("mdri: invalid argument: --from #{from}\n")
    end
  end

  it "names itself and says what it does, takes and reads on --help and -h, and runs nothing, in a project or outside one" do
    [@project, File.dirname(@project)].product(%w[--help -h]).each do |dir, flag|
      out, err, status = nil

      expect { out, err, status = mdri(flag, chdir: dir) }.not_to change { Dir.glob("**/*", base: @home) }, "#{flag} in #{dir}"
      expect(status).to be_success, "#{flag} in #{dir}: #{err}"
      expect(out).to start_with("mdri — reads the documentation yard-md wrote for a project's gems, by constant.\n\nUsage: mdri [--from N] <Constant>[#method|.method] [output dir]\n")
        .and include("bundle", "at those versions", "stderr", "writes nothing", "--version", "100 lines", "100 words", "200 characters")
        .and include("here, #{@home}/xdg/gem-docs.")
        .and match(/^ +--from N +starts the answer at line N$/)
    end
  end

  it "answers anything but one constant with its help, and runs nothing" do
    [[], %w[One two three]].each do |args|
      out, err, status = nil

      expect { out, err, status = mdri(*args) }.not_to change { Dir.glob("**/*", base: @home) }, args.inspect
      expect(status).not_to be_success, args.inspect
      expect(out).to be_empty
      expect(err).to eq(mdri("--help").first)
    end
  end
end
