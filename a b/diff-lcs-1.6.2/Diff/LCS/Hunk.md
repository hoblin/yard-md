# class Diff::LCS::Hunk
Defined in: `lib/diff/lcs/hunk.rb`

A Hunk is a group of Blocks which overlap because of the context surrounding
each block. (So if we're not using context, every hunk will contain one
block.) Used in the diff program (bin/ldiff).

## Instance attributes

### #blocks (read-only)

Returns the value of attribute blocks.

### #end_new (read-only)

Returns the value of attribute end_new.

### #end_old (read-only)

Returns the value of attribute end_old.

### #file_length_difference (read-only)

Returns the value of attribute file_length_difference.

### #flag_context

Change the "start" and "end" fields to note that context should be added
to this hunk.

### #start_new (read-only)

Returns the value of attribute start_new.

### #start_old (read-only)

Returns the value of attribute start_old.

## Instance methods

### #diff(format, last = false)

Returns a diff string based on a format.

### #initialize(data_old, data_new, piece, flag_context, file_length_difference)

Create a hunk using references to both the old and new data, as well as the
piece of data.

### #merge(hunk)

Merges this hunk and the provided hunk together if they overlap. Returns
a truthy value so that if there is no overlap, you can know the merge
was skipped.

Also known as: `unshift`

### #missing_last_newline?(data)

Returns: `Boolean`

### #overlaps?(hunk)

Determines whether there is an overlap between this hunk and the
provided hunk. This will be true if the difference between the two hunks
start or end positions is within one position of each other.

Returns: `Boolean`
