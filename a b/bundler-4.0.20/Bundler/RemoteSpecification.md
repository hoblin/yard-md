# class Bundler::RemoteSpecification
Includes: `Comparable`, `Bundler::MatchPlatform`, `Bundler::MatchRemoteMetadata`
Defined in: `lib/bundler/remote_specification.rb`

Represents a lazily loaded gem specification, where the full specification
is on the source server in rubygems' "quick" index. The proxy object is to
be seeded with what we're given from the source's abbreviated index - the
full specification will only be fetched when necessary.

## Instance attributes

### #created_at

Returns the value of attribute created_at.

### #dependencies

### #locked_platform

Returns the value of attribute locked_platform.

### #name (read-only)

Returns the value of attribute name.

### #platform (read-only)

Returns the value of attribute platform.

### #remote

Returns the value of attribute remote.

### #source

Returns the value of attribute source.

### #version (read-only)

Returns the value of attribute version.

## Instance methods

### #<=>(other)

Compare this specification against another object. Using sort_obj
is compatible with Gem::Specification and other Bundler or RubyGems
objects. Otherwise, use the default Object comparison.

### #__swap__(spec)

Because Rubyforge cannot be trusted to provide valid specifications
once the remote gem is downloaded, the backend specification will
be swapped out.

Raises: `APIResponseInvalidDependenciesError`

### #fetch_platform

Needed before installs, since the arch matters then and quick
specs don't bother to include the arch in the platform string

### #full_name

### #git_version

### #initialize(name, version, platform, spec_fetcher)

### #insecurely_materialized?

Returns: `Boolean`

### #respond_to?(method, include_all = false)

Returns: `Boolean`

### #runtime_dependencies

### #sort_obj

Create a delegate used for sorting. This strategy is copied from
RubyGems 2.23 and ensures that Bundler's specifications can be
compared and sorted with RubyGems' own specifications.

Returns: `Array` — an object you can use to compare and sort this
  specification against other specifications

See Also:
- `#<=>`
- `Gem::Specification#sort_obj`

### #to_s
