# class Bundler::Source::Path < Source
Defined in: `lib/bundler/source/path.rb`

## Constants

### DEFAULT_GLOB = "{,*,*/*}.gemspec"

## Instance attributes

### #name

### #options (read-only)

Returns the value of attribute options.

### #path (read-only)

Returns the value of attribute path.

Also known as: `to_gemfile`

### #root_path (read-only)

Returns the value of attribute root_path.

### #version

Returns the value of attribute version.

## Class methods

### .from_lock(options)

## Instance methods

### #app_cache_dirname

### #cache(spec, custom_path = nil)

### #eql?(other)

Returns: `Boolean`

Also known as: `==`

### #expanded_original_path

### #hash

### #initialize(options)

### #install(spec, options = {})

### #local_specs

### #root

### #specs

### #to_lock

### #to_s

Also known as: `identifier`
