# frozen_string_literal: true

require_relative "lib/yard_md/version"

Gem::Specification.new do |spec|
  spec.name = "yard-md"
  spec.version = YardMd::VERSION
  spec.authors = ["Yevhenii Hurin"]
  spec.email = ["evgeny.gurin@gmail.com"]

  spec.summary = "The documentation of installed gems as plain Markdown, for people and coding agents to read"
  spec.description = "Reads a gem's own documentation with YARD — its source comments and the prose files it ships — " \
                     "and writes it as Markdown pages, one per class or module, made to be read and searched by " \
                     "people and coding agents."
  spec.homepage = "https://github.com/hoblin/yard-md"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3"

  spec.metadata = {
    "source_code_uri" => "https://github.com/hoblin/yard-md",
    "changelog_uri" => "https://github.com/hoblin/yard-md/releases",
    "documentation_uri" => "https://rubydoc.info/gems/yard-md",
    "bug_tracker_uri" => "https://github.com/hoblin/yard-md/issues",
    "rubygems_mfa_required" => "true"
  }

  spec.files = Dir.glob("lib/**/*") + Dir.glob("exe/**/*") + %w[README.md LICENSE]
  spec.require_paths = ["lib"]
  spec.bindir = "exe"
  spec.executables = ["yard-md", "mdri"]

  spec.add_dependency "yard", "~> 0.9"
end
