# class Bundler::LazySpecification
Includes: `Bundler::ForcePlatform`, `Bundler::MatchPlatform`, `Bundler::MatchMetadata`
Defined in: `lib/bundler/lazy_specification.rb`

## Instance attributes

### #dependencies

Returns the value of attribute dependencies.

Also known as: `runtime_dependencies`

### #force_ruby_platform

Returns the value of attribute force_ruby_platform.

### #materialization (read-only)

Returns the value of attribute materialization.

### #most_specific_locked_platform

For backwards compatibility with existing lockfiles, if the most specific
locked platform is not a specific platform like x86_64-linux or
universal-java-11, then we keep the previous behaviour of resolving the
best platform variant at materiliazation time. For previous bundler
versions (before 2.2.0) this was always the case (except when the lockfile
only included non-ruby platforms), but we're also keeping this behaviour
on newer bundlers unless users generate the lockfile from scratch or
explicitly add a more specific platform.

### #name (read-only)

Returns the value of attribute name.

### #platform (read-only)

Returns the value of attribute platform.

### #remote

Returns the value of attribute remote.

### #required_ruby_version

Returns the value of attribute required_ruby_version.

### #required_rubygems_version

Returns the value of attribute required_rubygems_version.

### #source

Returns the value of attribute source.

### #version (read-only)

Returns the value of attribute version.

## Class methods

### .from_spec(s)

## Instance methods

### #==(other)

### #eql?(other)

Returns: `Boolean`

### #force_ruby_platform!

### #full_name

### #git_version

### #hash

### #incomplete?

Returns: `Boolean`

### #initialize(name, version, platform, source = nil, **materialization_options)

### #inspect

### #lock_name

### #materialize_for_cache

### #materialize_for_installation

### #materialized_for_installation

### #missing?

Returns: `Boolean`

### #name_tuple

### #replace_source_with!(gemfile_source)

### #satisfies?(dependency)

Does this locked specification satisfy `dependency`?

NOTE: Rubygems default requirement is ">= 0", which doesn't match
prereleases of 0 versions, like "0.0.0.dev" or "0.0.0.SNAPSHOT". However,
bundler users expect those to work. We need to make sure that Gemfile
dependencies without explicit requirements (which use ">= 0" under the
hood by default) are still valid for locked specs using this kind of
versions. The method implements an ad-hoc fix for that. A better solution
might be to change default rubygems requirement of dependencies to be ">=
0.A" but that's a major refactoring likely to break things. Hopefully we
can attempt it in the future.

Returns: `Boolean`

### #source_changed?

Returns: `Boolean`

### #to_lock

### #to_s
