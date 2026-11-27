# class Bundler::RubyVersion
Defined in: `lib/bundler/ruby_version.rb`

## Instance attributes

### #engine (read-only)

Returns the value of attribute engine.

### #engine_gem_version (read-only)

Returns the value of attribute engine_gem_version.

### #engine_versions (read-only)

Returns the value of attribute engine_versions.

### #gem_version (read-only)

Returns the value of attribute gem_version.

### #patchlevel (read-only)

Returns the value of attribute patchlevel.

### #versions (read-only)

Returns the value of attribute versions.

## Class methods

### .from_string(string)

Returns a RubyVersion from the given string.

Parameters:
- `the` (`String`) — version string to match.

Returns: `RubyVersion, Nil` — The version if the string is a valid RubyVersion
  description, and nil otherwise.

### .system

## Instance methods

### #==(other)

### #diff(other)

Returns a tuple of these things:
```
[diff, this, other]
The priority of attributes are
1. engine
2. ruby_version
3. engine_version
```

Raises: `ArgumentError`

### #host

### #initialize(versions, patchlevel, engine, engine_version)

### #single_version_string

### #to_s(versions = self.versions)

### #versions_string(versions)
