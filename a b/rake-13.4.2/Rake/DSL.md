# module Rake::DSL
Includes: `Rake::FileUtilsExt`
Defined in: `lib/rake/dsl_definition.rb`

DSL is a module that provides #task, #desc, #namespace, etc.  Use this
when you'd like to use rake outside the top level scope.

For a Rakefile you run from the command line this module is automatically
included.
