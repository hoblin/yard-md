# class Bundler::Index
Includes: `Enumerable`
Defined in: `lib/bundler/index.rb`

## Constants

### NULL = "\0"

### RUBY = "ruby"

## Instance attributes

### #sources (read-only)

Returns the value of attribute sources.

## Class methods

### .build {|i| ... }

Yields: `i`

## Instance methods

### #add(spec)

Also known as: `<<`

### #add_source(index)

Raises: `ArgumentError`

### #dependencies_eql?(spec, other_spec)

Returns: `Boolean`

### #dependency_names

### #each(&blk)

### #empty?

Returns: `Boolean`

### #initialize

### #initialize_copy(o)

### #inspect

### #local_search(query)

### #merge!(other)

Combines indexes proritizing specs from `other`, like `Hash#merge!`
Duplicate specs found in `self` are saved in `@duplicates`.

### #search(query)

Search this index's specs, and any source indexes that this index knows
about, returning all of the results.

Also known as: `[]`

### #size

### #spec_names

### #subset?(other)

Whether all the specs in self are in other

Returns: `Boolean`

### #unmet_dependency_names

### #use(other)

Combines indexes proritizing existing specs, like `Hash#reverse_merge!`
Duplicate specs found in `other` are stored in `@duplicates`.
