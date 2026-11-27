# class Bundler::PubGrub::VersionUnion
Defined in: `lib/bundler/vendor/pub_grub/lib/pub_grub/version_union.rb`

## Instance attributes

### #ranges (read-only)

Returns the value of attribute ranges.

## Class methods

### .normalize_ranges(ranges)

### .union(ranges, normalize: true)

## Instance methods

### #==(other)

### #allows_all?(other)

Returns: `Boolean`

### #any?

Returns: `Boolean`

### #empty?

Returns: `Boolean`

### #eql?(other)

Returns: `Boolean`

### #hash

### #include?(version)

Returns: `Boolean`

### #initialize(ranges)

Raises: `ArgumentError`

### #inspect

### #intersect(other)

### #intersects?(other)

Returns: `Boolean`

Also known as: `allows_any?`

### #invert

### #select_versions(all_versions)

### #to_s

### #union(other)

### #upper_invert
