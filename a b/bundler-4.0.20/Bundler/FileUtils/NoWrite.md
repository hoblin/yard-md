# module Bundler::FileUtils::NoWrite
Includes: `Bundler::FileUtils::LowMethods`, `Bundler::FileUtils`
Extended by: `Bundler::FileUtils::NoWrite`
Defined in: `lib/bundler/vendor/fileutils/lib/fileutils.rb`

This module has all methods of Bundler::FileUtils module, but never changes
files/directories.  This equates to passing the `:noop` flag
to methods in Bundler::FileUtils.
