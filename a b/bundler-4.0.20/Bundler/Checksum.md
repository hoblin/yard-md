# class Bundler::Checksum
Defined in: `lib/bundler/checksum.rb`

## Constants

### ALGO_SEPARATOR = "="

## Instance attributes

### #algo (read-only)

Returns the value of attribute algo.

### #digest (read-only)

Returns the value of attribute digest.

### #sources (read-only)

Returns the value of attribute sources.

## Class methods

### .from_api(digest, source_uri, algo = DEFAULT_ALGORITHM)

### .from_gem(io, pathname, algo = DEFAULT_ALGORITHM)

### .from_gem_package(gem_package, algo = DEFAULT_ALGORITHM)

### .from_lock(lock_checksum, lockfile_location)

### .to_hexdigest(digest, algo = DEFAULT_ALGORITHM)

## Instance methods

### #==(other)

Also known as: `eql?`

### #formatted_sources

### #hash

### #initialize(algo, digest, source)

### #inspect

### #match?(other)

Returns: `Boolean`

### #merge!(other)

### #removable?

Returns: `Boolean`

### #removal_instructions

### #same_source?(other)

Returns: `Boolean`

### #to_lock

### #to_s
