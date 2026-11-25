# frozen_string_literal: true

module Broken
  Alias = Object

  module Mixin; end
end

Broken::Alias.include Broken::Mixin
