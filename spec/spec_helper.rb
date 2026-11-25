# frozen_string_literal: true

require "yard_md"
require_relative "support/fixture_project"

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :expect }
  config.order = :random
  Kernel.srand config.seed
end
