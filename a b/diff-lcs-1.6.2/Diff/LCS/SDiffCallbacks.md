# class Diff::LCS::SDiffCallbacks
Defined in: `lib/diff/lcs/callbacks.rb`

This will produce a simple array of diff change objects. Each element in
the #diffs array is a single ContextChange. In the set of #diffs provided
by SDiffCallbacks, both old and new objects will be presented for both
changed <strong>and unchanged</strong> objects. `nil` will be substituted
for a discarded object.

The diffset produced by this callback, when provided to Diff::LCS#sdiff,
will compute and display the necessary components to show two sequences
and their minimized differences side by side, just like the Unix utility
`sdiff`.

```
same             same
before     |     after
old        <     -
-          >     new

seq1 = %w(a b c e h j l m n p)
seq2 = %w(b c d e f j k l m r s t)

diffs = Diff::LCS.sdiff(seq1, seq2)
  # This example shows a simplified array format.
  # [ [ "-", [  0, "a"], [  0, nil ] ],
  #   [ "=", [  1, "b"], [  0, "b" ] ],
  #   [ "=", [  2, "c"], [  1, "c" ] ],
  #   [ "+", [  3, nil], [  2, "d" ] ],
  #   [ "=", [  3, "e"], [  3, "e" ] ],
  #   [ "!", [  4, "h"], [  4, "f" ] ],
  #   [ "=", [  5, "j"], [  5, "j" ] ],
  #   [ "+", [  6, nil], [  6, "k" ] ],
  #   [ "=", [  6, "l"], [  7, "l" ] ],
  #   [ "=", [  7, "m"], [  8, "m" ] ],
  #   [ "!", [  8, "n"], [  9, "r" ] ],
  #   [ "!", [  9, "p"], [ 10, "s" ] ],
  #   [ "+", [ 10, nil], [ 11, "t" ] ] ]
```

The result of this operation is similar to that of
Diff::LCS::ContextDiffCallbacks. They may be compared as:

```
s = Diff::LCS.sdiff(seq1, seq2).reject { |e| e.action == "=" }
c = Diff::LCS.sdiff(seq1, seq2, Diff::LCS::ContextDiffCallbacks).flatten(1)

s == c # -> true
```

#### Use

This callback object must be initialised and is used by the Diff::LCS#sdiff
method.

```
cbo = Diff::LCS::SDiffCallbacks.new
Diff::LCS.LCS(seq1, seq2, cbo)
```

As with the other initialisable callback objects,
Diff::LCS::SDiffCallbacks can be initialised with a block. As there is no
"fininishing" to be done, this has no effect on the state of the object.

```
cbo = Diff::LCS::SDiffCallbacks.new { |tcbo| Diff::LCS.LCS(seq1, seq2, tcbo) }
```

#### Simplified Array Format

The simplified array format used in the example above can be obtained
with:

```
require 'pp'
pp diffs.map { |e| e.to_a }
```

## Instance attributes

### #diffs (read-only)

Returns the difference set collected during the diff process.

## Instance methods

### #change(event)

### #discard_a(event)

### #discard_b(event)

### #initialize {|_self| ... }

:yields: self

Yields: `_self`

Yield Parameters:
- `_self` (`Diff::LCS::SDiffCallbacks`) — the object that the method was called on

### #match(event)
