# class Bundler::Checksum::Source
Defined in: `lib/bundler/checksum.rb`

## Instance attributes

### #location (read-only)

Returns the value of attribute location.

### #type (read-only)

Returns the value of attribute type.

## Instance methods

### #==(other)

### #initialize(type, location)

### #removable?

Returns: `Boolean`

### #removal

A full sentence describing how to remove the checksum

### #to_s

phrased so that the usual string format is grammatically correct
```
rake (10.3.2) sha256=abc123 from #{to_s}
```
