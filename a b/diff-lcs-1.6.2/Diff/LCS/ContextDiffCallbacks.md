# class Diff::LCS::ContextDiffCallbacks < Diff::LCS::DiffCallbacks
Defined in: `lib/diff/lcs/callbacks.rb`

This will produce a compound array of contextual diff change objects. Each
element in the #diffs array is a "hunk" array, where each element in each
"hunk" array is a single change. Each change is a Diff::LCS::ContextChange
that contains both the old index and new index values for the change. The
"hunk" provides the full context for the changes. Both old and new objects
will be presented for changed objects. `nil` will be substituted for a
discarded object.

```
seq1 = %w(a b c e h j l m n p)
seq2 = %w(b c d e f j k l m r s t)

diffs = Diff::LCS.diff(seq1, seq2, Diff::LCS::ContextDiffCallbacks)
  # This example shows a simplified array format.
  # [ [ [ '-', [  0, 'a' ], [  0, nil ] ] ],   # 1
  #   [ [ '+', [  3, nil ], [  2, 'd' ] ] ],   # 2
  #   [ [ '-', [  4, 'h' ], [  4, nil ] ],     # 3
  #     [ '+', [  5, nil ], [  4, 'f' ] ] ],
  #   [ [ '+', [  6, nil ], [  6, 'k' ] ] ],   # 4
  #   [ [ '-', [  8, 'n' ], [  9, nil ] ],     # 5
  #     [ '+', [  9, nil ], [  9, 'r' ] ],
  #     [ '-', [  9, 'p' ], [ 10, nil ] ],
  #     [ '+', [ 10, nil ], [ 10, 's' ] ],
  #     [ '+', [ 10, nil ], [ 11, 't' ] ] ] ]
```

The five hunks shown are comprised of individual changes; if there is a
related set of changes, they are still shown individually.

This callback can also be used with Diff::LCS#sdiff, which will produce
results like:

```
diffs = Diff::LCS.sdiff(seq1, seq2, Diff::LCS::ContextCallbacks)
  # This example shows a simplified array format.
  # [ [ [ "-", [  0, "a" ], [  0, nil ] ] ],  # 1
  #   [ [ "+", [  3, nil ], [  2, "d" ] ] ],  # 2
  #   [ [ "!", [  4, "h" ], [  4, "f" ] ] ],  # 3
  #   [ [ "+", [  6, nil ], [  6, "k" ] ] ],  # 4
  #   [ [ "!", [  8, "n" ], [  9, "r" ] ],    # 5
  #     [ "!", [  9, "p" ], [ 10, "s" ] ],
  #     [ "+", [ 10, nil ], [ 11, "t" ] ] ] ]
```

The five hunks are still present, but are significantly shorter in total
presentation, because changed items are shown as changes ("!") instead of
potentially "mismatched" pairs of additions and deletions.

The result of this operation is similar to that of
Diff::LCS::SDiffCallbacks. They may be compared as:

```
s = Diff::LCS.sdiff(seq1, seq2).reject { |e| e.action == "=" }
c = Diff::LCS.sdiff(seq1, seq2, Diff::LCS::ContextDiffCallbacks).flatten(1)

s == c # -> true
```

#### Use

This callback object must be initialised and can be used by the
Diff::LCS#diff or Diff::LCS#sdiff methods.

```
cbo = Diff::LCS::ContextDiffCallbacks.new
Diff::LCS.LCS(seq1, seq2, cbo)
cbo.finish
```

Note that the call to #finish is absolutely necessary, or the last set of
changes will not be visible. Alternatively, can be used as:

```
cbo = Diff::LCS::ContextDiffCallbacks.new { |tcbo| Diff::LCS.LCS(seq1, seq2, tcbo) }
```

The necessary #finish call will be made.

#### Simplified Array Format

The simplified array format used in the example above can be obtained
with:

```
require 'pp'
pp diffs.map { |e| e.map { |f| f.to_a } }
```

## Instance methods

### #change(event)

### #discard_a(event)

### #discard_b(event)
