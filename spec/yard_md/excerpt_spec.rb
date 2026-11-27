# frozen_string_literal: true

RSpec.describe YardMd::Excerpt do
  def excerpt(text, from = 1)
    described_class.new(text, from).page("mdri Big")
  end

  def numbered(count)
    (1..count).map { |line| "line #{line}\n" }.join
  end

  describe "#page" do
    it "leaves an answer within every limit as it is" do
      expect(excerpt("### #find\n\nFinds it.\n")).to eq("### #find\n\nFinds it.\n")
    end

    it "shows the first 100 lines, then the total and the command for the next" do
      expect(excerpt(numbered(250))).to eq("#{numbered(100)}[Showing lines 1–100 of 250. mdri Big --from 101 for the next.]\n")
    end

    it "starts at the line it is given" do
      expect(excerpt(numbered(250), 101).lines.values_at(0, 99, 100)).to eq(
        ["line 101\n", "line 200\n", "[Showing lines 101–200 of 250. mdri Big --from 201 for the next.]\n"]
      )
    end

    it "shows the total but no next command on the last lines" do
      expect(excerpt(numbered(250), 241)).to eq("#{numbered(250).lines[240..].join}[Showing lines 241–250 of 250.]\n")
    end

    it "answers nothing past the last line" do
      expect(excerpt(numbered(3), 4)).to be_nil
    end

    it "cuts a line to 100 words, keeping their spacing, and says how many more there were" do
      words = (1..340).map { |word| "w#{word}" }

      expect(excerpt("  #{words.join("  ")}\n")).to eq("  #{words.first(100).join("  ")} … [+240 words]\n")
    end

    it "cuts a word to 200 characters and says how many more there were" do
      expect(excerpt("REGEX = /#{"a" * 12_000}/\n")).to eq("REGEX = /#{"a" * 199}… [+11802 chars]\n")
    end

    it "leaves a line of exactly 100 words and a word of exactly 200 characters whole" do
      line = "#{(["w"] * 99).join(" ")} #{"c" * 200}\n"

      expect(excerpt(line)).to eq(line)
    end

    it "cuts words before characters, so a cut word's marker is not counted as words" do
      line = (["c" * 300] * 101).join(" ")

      expect(excerpt("#{line}\n")).to eq("#{(["#{"c" * 200}… [+100 chars]"] * 100).join(" ")} … [+1 words]\n")
    end

    it "keeps a last line that has no newline without one, and puts its own line under it" do
      expect(excerpt("b" * 300)).to eq("#{"b" * 200}… [+100 chars]")
      expect(excerpt("a\nb", 2)).to eq("b\n[Showing lines 2–2 of 2.]\n")
    end
  end
end
