# class Diff::LCS::DiffCallbacks
Defined in: `lib/diff/lcs/callbacks.rb`

This will produce a compound array of simple diff change objects. Each
element in the #diffs array is a `hunk` or `hunk` array, where each
element in each `hunk` array is a single Change object representing the
addition or removal of a single element from one of the two tested
sequences. The `hunk` provides the full context for the changes.

```
diffs = Diff::LCS.diff(seq1, seq2)
  # This example shows a simplified array format.
  # [ [ [ '-',  0, 'a' ] ],   # 1
  #   [ [ '+',  2, 'd' ] ],   # 2
  #   [ [ '-',  4, 'h' ],     # 3
  #     [ '+',  4, 'f' ] ],
  #   [ [ '+',  6, 'k' ] ],   # 4
  #   [ [ '-',  8, 'n' ],     # 5
  #     [ '-',  9, 'p' ],
  #     [ '+',  9, 'r' ],
  #     [ '+', 10, 's' ],
  #     [ '+', 11, 't' ] ] ]
```

There are five hunks here. The first hunk says that the `a` at position 0
of the first sequence should be deleted (`'-'`). The second hunk
says that the `d` at position 2 of the second sequence should be inserted
(`'+'`). The third hunk says that the `h` at position 4 of the
first sequence should be removed and replaced with the `f` from position 4
of the second sequence. The other two hunks are described similarly.

#### Use

This callback object must be initialised and is used by the Diff::LCS#diff
method.

```
cbo = Diff::LCS::DiffCallbacks.new
Diff::LCS.LCS(seq1, seq2, cbo)
cbo.finish
```

Note that the call to #finish is absolutely necessary, or the last set of
changes will not be visible. Alternatively, can be used as:

```
cbo = Diff::LCS::DiffCallbacks.new { |tcbo| Diff::LCS.LCS(seq1, seq2, tcbo) }
```

The necessary #finish call will be made.

#### Simplified Array Format

The simplified array format used in the example above can be obtained
with:

```
require 'pp'
pp diffs.map { |e| e.map { |f| f.to_a } }
```

## Instance attributes

### #diffs (read-only)

Returns the difference set collected during the diff process.

## Instance methods

### #discard_a(event)

### #discard_b(event)

### #finish

Finalizes the diff process. If an unprocessed hunk still exists, then it
is appended to the diff list.

### #initialize

:yields: self

### #match(_event)
