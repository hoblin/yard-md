# class Diff::LCS::DefaultCallbacks
Defined in: `lib/diff/lcs/callbacks.rb`

This callback object implements the default set of callback events,
which only returns the event itself. Note that #finished_a and
#finished_b are not implemented -- I haven't yet figured out where they
would be useful.

Note that this is intended to be called as is, e.g.,

```
Diff::LCS.LCS(seq1, seq2, Diff::LCS::DefaultCallbacks)
```

## Class methods

### .change(event)

Called when both the old and new values have changed.

### .discard_a(event)

Called when the old value is discarded in favour of the new value.

### .discard_b(event)

Called when the new value is discarded in favour of the old value.

### .match(event)

Called when two items match.
