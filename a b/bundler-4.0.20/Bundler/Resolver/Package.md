# class Bundler::Resolver::Package
Defined in: `lib/bundler/resolver/package.rb`

Represents a gem being resolved, in a format PubGrub likes.

The class holds the following information:

* Platforms this gem will be resolved on.
* The locked version of this gem resolution should favor (if any).
* Whether the gem should be unlocked to its latest version.
* The dependency explicit set in the Gemfile for this gem (if any).

## Instance attributes

### #dependency (read-only)

Returns the value of attribute dependency.

### #locked_version (read-only)

Returns the value of attribute locked_version.

### #name (read-only)

Returns the value of attribute name.

### #platforms (read-only)

Returns the value of attribute platforms.

## Instance methods

### #==(other)

### #consider_prereleases!

### #consider_remote_versions!

### #current_platform?

Returns: `Boolean`

### #force_ruby_platform?

Returns: `Boolean`

### #hash

### #ignores_prereleases?

Returns: `Boolean`

### #initialize(name, platforms, locked_specs:, unlock:, prerelease: false, prefer_local: false, dependency: nil, new_platforms: [])

### #meta?

Returns: `Boolean`

### #platform_specs(specs)

### #prefer_local?

Returns: `Boolean`

### #prerelease_specified?

Returns: `Boolean`

### #root?

Returns: `Boolean`

### #to_s

### #top_level?

Returns: `Boolean`

### #unlock?

Returns: `Boolean`
