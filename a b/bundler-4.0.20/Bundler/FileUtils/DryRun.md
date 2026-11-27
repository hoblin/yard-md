# module Bundler::FileUtils::DryRun
Includes: `Bundler::FileUtils::LowMethods`, `Bundler::FileUtils`
Extended by: `Bundler::FileUtils::DryRun`
Defined in: `lib/bundler/vendor/fileutils/lib/fileutils.rb`

This module has all methods of Bundler::FileUtils module, but never changes
files/directories, with printing message before acting.
This equates to passing the `:noop` and `:verbose` flag
to methods in Bundler::FileUtils.
