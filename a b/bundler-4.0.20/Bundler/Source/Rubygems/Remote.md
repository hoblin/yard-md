# class Bundler::Source::Rubygems::Remote
Defined in: `lib/bundler/source/rubygems/remote.rb`

## Instance attributes

### #anonymized_uri (read-only)

Returns the value of attribute anonymized_uri.

### #cooldown (read-only)

Returns the value of attribute cooldown.

### #original_uri (read-only)

Returns the value of attribute original_uri.

### #uri (read-only)

Returns the value of attribute uri.

## Instance methods

### #cache_slug

Returns: `String` — A slug suitable for use as a cache key for this
  remote.

### #effective_cooldown

Returns the cooldown days that apply to this remote, resolving the
precedence CLI > config > Gemfile per-source. Returns nil if no
cooldown applies.

### #initialize(uri, cooldown: nil)

### #to_s
