# class Bundler::GemHelper
Includes: `Rake::DSL`
Defined in: `lib/bundler/gem_helper.rb`

## Class attributes

### .instance

set when install'd.

## Instance attributes

### #base (read-only)

Returns the value of attribute base.

### #gemspec (read-only)

Returns the value of attribute gemspec.

### #spec_path (read-only)

Returns the value of attribute spec_path.

### #tag_prefix (write-only)

Sets the attribute tag_prefix

Parameters:
- `value` — the value to set the attribute tag_prefix to.

## Class methods

### .gemspec(&block)

### .install_tasks(opts = {})

### .tag_prefix=(prefix)

## Instance methods

### #build_checksum(built_gem_path = nil)

### #build_gem

### #initialize(base = nil, name = nil)

### #install

### #install_gem(built_gem_path = nil, local = false)
