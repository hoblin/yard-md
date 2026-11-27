# class Diff::LCS::Block
Defined in: `lib/diff/lcs/block.rb`

A block is an operation removing, adding, or changing a group of items.
Basically, this is just a list of changes, where each change adds or
deletes a single item. Used by bin/ldiff.

## Instance attributes

### #changes (read-only)

Returns the value of attribute changes.

### #insert (read-only)

Returns the value of attribute insert.

### #remove (read-only)

Returns the value of attribute remove.

## Instance methods

### #diff_size

### #initialize(chunk)

### #op
