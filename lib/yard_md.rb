# frozen_string_literal: true

require "bundler"
require "fileutils"
require "json"
require "tmpdir"
require "yard"

require_relative "yard_md/version"
require_relative "yard_md/rdoc_markup"
require_relative "yard_md/prose"
require_relative "yard_md/page"
require_relative "yard_md/gem_docs"
require_relative "yard_md/bundle"

# The documentation of installed gems as plain Markdown.
module YardMd
  cache_home = Gem.cache_home
  cache_home = File.join(Gem.user_home, ".cache") unless File.absolute_path?(cache_home)

  # Where the documentation goes unless told otherwise.
  CACHE = File.join(cache_home, "gem-docs")

  # The file in each gem's directory that {Bundle#read} answers from, beside
  # the pages it indexes.
  # @api private
  INDEX = ".index.json"
end
