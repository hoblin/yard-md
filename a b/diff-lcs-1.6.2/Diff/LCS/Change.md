# class Diff::LCS::Change
Includes: `Comparable`
Defined in: `lib/diff/lcs/change.rb`

Represents a simplistic (non-contextual) change. Represents the removal or
addition of an element from either the old or the new sequenced
enumerable.

## Constants

### IntClass = 1.class

Fixnum is deprecated in Ruby 2.4 # standard:disable Naming/ConstantName

### VALID_ACTIONS = %w[+ - = ! > <].freeze

The only actions valid for changes are '+' (add), '-' (delete), '='
(no change), '!' (changed), '<' (tail changes from first sequence), or
'>' (tail changes from second sequence). The last two ('<>') are only
found with Diff::LCS::diff and Diff::LCS::sdiff.

## Instance attributes

### #action (read-only)

Returns the action this Change represents.

### #element (read-only)

Returns the sequence element of the Change.

### #position (read-only)

Returns the position of the Change.

## Class methods

### .from_a(arr)

### .valid_action?(action)

Returns: `Boolean`

## Instance methods

### #<=>(other)

### #==(other)

### #adding?

Returns: `Boolean`

### #changed?

Returns: `Boolean`

### #deleting?

Returns: `Boolean`

### #finished_a?

Returns: `Boolean`

### #finished_b?

Returns: `Boolean`

### #initialize(*args)

### #inspect(*_args)

### #to_a

Also known as: `to_ary`

### #unchanged?

Returns: `Boolean`
