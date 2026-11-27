# class Diff::LCS::ContextChange < Diff::LCS::Change
Defined in: `lib/diff/lcs/change.rb`

Represents a contextual change. Contains the position and values of the
elements in the old and the new sequenced enumerables as well as the action
taken.

## Instance attributes

### #new_element (read-only)

Returns the new element being changed.

### #new_position (read-only)

Returns the new position being changed.

### #old_element (read-only)

Returns the old element being changed.

### #old_position (read-only)

Returns the old position being changed.

## Class methods

### .from_a(arr)

### .simplify(event)

Simplifies a context change for use in some diff callbacks. '<' actions
are converted to '-' and '>' actions are converted to '+'.

## Instance methods

### #<=>(other)

### #==(other)

### #initialize(*args)

### #to_a

Also known as: `to_ary`
