# class Bundler::Source
Defined in: `lib/bundler/source.rb`

## Instance attributes

### #checksum_store (read-only)

Returns the value of attribute checksum_store.

### #dependency_names

Returns the value of attribute dependency_names.

## Instance methods

### #add_dependency_names(names)

### #cached!

### #can_lock?(spec)

Returns: `Boolean`

### #dependency_names_to_double_check

### #double_check_for

it's possible that gems from one source depend on gems from some
other source, so now we download gemspecs and iterate over those
dependencies, looking for gems we don't have info on yet.

### #download

### #extension_cache_path(spec)

### #identifier

### #include?(other)

Returns: `Boolean`

### #inspect

### #local!

### #local_only!

### #path?

Returns: `Boolean`

### #prefer_local!

### #remote!

### #spec_names

### #unmet_deps

### #version_message(spec, locked_spec = nil)
