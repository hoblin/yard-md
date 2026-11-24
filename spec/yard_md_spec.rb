# frozen_string_literal: true

RSpec.describe YardMd do
  it "has a version" do
    expect(YardMd::VERSION).to match(/\A\d+\.\d+\.\d+\z/)
  end
end
