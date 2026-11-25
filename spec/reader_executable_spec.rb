# frozen_string_literal: true

RSpec.describe "exe/yard-md-ri" do
  include_context "with the fixture project"

  def yard_md_ri(...)
    run("yard-md-ri", ...)
  end

  describe "in a project yard-md documented" do
    before { run("yard-md") }

    it "lists a namespace's classes and modules" do
      out, err, status = yard_md_ri("Sample")

      expect(status).to be_success, err
      expect(out).to eq("Sample::Empty\nSample::Notes\nSample::Widget\n")
    end

    it "prints a method's documentation" do
      out, err, status = yard_md_ri("Sample::Widget.find")

      expect(status).to be_success, err
      expect(out).to eq("### .find(color)\n\nFinds a widget by color.\n\nDeprecated: Use `.where` instead.\n")
    end

    it "says on stderr that nothing documents what it was asked" do
      out, err, status = yard_md_ri("Sample::Widget#nope")

      expect(status).not_to be_success
      expect(out).to be_empty
      expect(err).to eq("yard-md-ri: nothing in the bundle documents Sample::Widget#nope\n")
    end
  end

  it "reads from the directory it is given" do
    run("yard-md", "docs")

    out, err, status = yard_md_ri("Sample::Empty", "docs")

    expect(status).to be_success, err
    expect(out).to eq("Sample::Empty::Inner\n")
  end

  it "says what it does, takes and reads on --help and -h, and runs nothing, in a project or outside one" do
    [@project, File.dirname(@project)].product(%w[--help -h]).each do |dir, flag|
      out, err, status = nil

      expect { out, err, status = yard_md_ri(flag, chdir: dir) }.not_to change { Dir.glob("**/*", base: @home) }, "#{flag} in #{dir}"
      expect(status).to be_success, "#{flag} in #{dir}: #{err}"
      expect(out).to start_with("Usage: yard-md-ri <Constant>[#method|.method] [output dir]\n")
        .and include("bundle", "at those versions", "stderr", "writes nothing", "--version")
        .and include("here, #{@home}/xdg/gem-docs.")
    end
  end

  it "answers anything but one constant with its help, and runs nothing" do
    [[], %w[One two three]].each do |args|
      out, err, status = yard_md_ri(*args)

      expect(status).not_to be_success, args.inspect
      expect(out).to be_empty
      expect(err).to start_with("Usage: yard-md-ri ")
    end
  end
end
