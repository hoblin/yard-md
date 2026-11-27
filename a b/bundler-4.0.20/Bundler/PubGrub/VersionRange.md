# class Bundler::PubGrub::VersionRange
Defined in: `lib/bundler/vendor/pub_grub/lib/pub_grub/version_range.rb`

## Constants

### EMPTY = Empty.new

## Instance attributes

### #include_max (read-only)

Returns the value of attribute include_max.

Also known as: `include_max?`

### #include_min (read-only)

Returns the value of attribute include_min.

Also known as: `include_min?`

### #max (read-only)

Returns the value of attribute max.

### #min (read-only)

Returns the value of attribute min.

## Class methods

### .any

### .empty

## Instance methods

### #==(other)

### #allows_all?(other)

Returns: `Boolean`

### #any?

Returns: `Boolean`

### #compare_version(version)

### #contiguous_above?(other)

Returns: `Boolean`

### #contiguous_below?(other)

Returns: `Boolean`

### #contiguous_to?(other)

Returns: `Boolean`

### #empty?

Returns: `Boolean`

### #eql?(other)

Returns: `Boolean`

### #hash

### #include?(version)

Returns: `Boolean`

### #initialize(min: nil, max: nil, include_min: false, include_max: false, name: nil)

Raises: `ArgumentError`

### #inspect

### #intersect(other)

### #intersects?(other)

Returns: `Boolean`

Also known as: `allows_any?`

### #invert

### #partition_versions(versions)

Partitions passed versions into [lower, within, higher]

versions must be sorted

### #ranges

### #select_versions(versions)

Returns versions which are included by this range.

versions must be sorted

### #span(other)

The span covered by two ranges

If self and other are contiguous, this builds a union of the two ranges.
(if they aren't you are probably calling the wrong method)

### #strictly_higher?(other)

Returns: `Boolean`

### #strictly_lower?(other)

Returns: `Boolean`

### #to_s

### #union(other)

### #upper_invert
