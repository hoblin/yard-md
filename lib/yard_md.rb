# frozen_string_literal: true

require "bundler"
require "fileutils"
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
  # Where the documentation goes unless told otherwise: the user's cache
  # directory, which follows +XDG_CACHE_HOME+.
  CACHE = File.join(Gem.cache_home, "gem-docs")
end
