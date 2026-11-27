# module Bundler::ForcePlatform
Defined in: `lib/bundler/force_platform.rb`

## Instance methods

### #default_force_ruby_platform

The `:force_ruby_platform` value used by dependencies for resolution, and
by locked specifications for materialization is `false` by default, except
for TruffleRuby. TruffleRuby generally needs to force the RUBY platform
variant unless the name is explicitly allowlisted.
