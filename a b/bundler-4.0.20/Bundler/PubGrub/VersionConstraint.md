# class Bundler::PubGrub::VersionConstraint
Defined in: `lib/bundler/vendor/pub_grub/lib/pub_grub/version_constraint.rb`

## Instance attributes

### #package (read-only)

Returns the value of attribute package.

### #range (read-only)

Returns the value of attribute range.

## Class methods

### .any(package)

### .empty(package)

### .exact(package, version)

## Instance methods

### #==(other)

### #allows_all?(other)

Returns: `Boolean`

### #allows_any?(other)

Returns: `Boolean`

### #any?

Does this match every version of the package

Returns: `Boolean`

### #constraint_string

### #difference(other)

### #disjoint?(other)

Returns: `Boolean`

### #empty?

Returns: `Boolean`

### #eql?(other)

Returns: `Boolean`

### #hash

### #initialize(package, range: nil)

Parameters:
- `package` (`Bundler::PubGrub::Package`)
- `range` (`Bundler::PubGrub::VersionRange`)

### #inspect

### #intersect(other)

### #invert

### #overlap?(other)

Returns: `Boolean`

### #relation(other)

### #subset?(other)

Returns: `Boolean`

### #to_s(allow_every: false)

### #union(other)
