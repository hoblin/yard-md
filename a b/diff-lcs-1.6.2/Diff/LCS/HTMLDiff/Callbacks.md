# class Diff::LCS::HTMLDiff::Callbacks
Defined in: `lib/diff/lcs/htmldiff.rb`

## Instance attributes

### #match_class

Returns the value of attribute match_class.

### #only_a_class

Returns the value of attribute only_a_class.

### #only_b_class

Returns the value of attribute only_b_class.

### #output

Returns the value of attribute output.

## Instance methods

### #discard_a(event)

This will be called when there is a line in A that isn't in B

### #discard_b(event)

This will be called when there is a line in B that isn't in A

### #initialize(output, options = {})

### #match(event)

This will be called with both lines are the same
