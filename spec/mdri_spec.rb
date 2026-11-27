# frozen_string_literal: true

RSpec.describe "exe/mdri" do
  include_context "with the fixture project"

  def mdri(...)
    run("mdri", ...)
  end

  describe "in a project yard-md documented" do
    before { expect(run("yard-md").last).to be_success }

    it "lists a namespace's classes and modules" do
      out, err, status = mdri("Sample")

      expect(status).to be_success, err
      expect(out).to eq("Sample::Empty\nSample::Notes\nSample::Widget\n")
    end

    it "prints a method's documentation" do
      out, err, status = mdri("Sample::Widget.find")

      expect(status).to be_success, err
      expect(out).to eq("### .find(color)\n\nFinds a widget by color.\n\nDeprecated: Use `.where` instead.\n")
    end

    it "says on stderr that nothing documents what it was asked" do
      out, err, status = mdri("Sample::Widget#nope")

      expect(status).not_to be_success
      expect(out).to be_empty
      expect(err).to eq("mdri: nothing in the bundle documents Sample::Widget#nope\n")
    end
  end

  it "says in one line why a bundle it cannot resolve stops it" do
    File.write(File.join(@project, "Gemfile"), %(gem "absent", path: "../absent"\n))

    _, err, status = mdri("Sample")

    expect(status).not_to be_success
    expect(err.lines.size).to eq(1)
    expect(err).to start_with("mdri: ").and include("absent")
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
    expect(out).to eq("Sample::Empty::Inner\n")
  end

  it "says what it does, takes and reads on --help and -h, and runs nothing, in a project or outside one" do
    [@project, File.dirname(@project)].product(%w[--help -h]).each do |dir, flag|
      out, err, status = nil

      expect { out, err, status = mdri(flag, chdir: dir) }.not_to change { Dir.glob("**/*", base: @home) }, "#{flag} in #{dir}"
      expect(status).to be_success, "#{flag} in #{dir}: #{err}"
      expect(out).to start_with("Reads the documentation yard-md wrote for a project's gems, by constant.\n\nUsage: mdri <Constant>[#method|.method] [output dir]\n")
        .and include("bundle", "at those versions", "stderr", "writes nothing", "--version")
        .and include("here, #{@home}/xdg/gem-docs.")
    end
  end

  it "answers anything but one constant with its help, and runs nothing" do
    [[], %w[One two three]].each do |args|
      out, err, status = nil

      expect { out, err, status = mdri(*args) }.not_to change { Dir.glob("**/*", base: @home) }, args.inspect
      expect(status).not_to be_success, args.inspect
      expect(out).to be_empty
      expect(err).to start_with("Reads the documentation yard-md wrote for a project's gems, by constant.\n\nUsage: mdri ")
    end
  end
end
