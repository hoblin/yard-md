# module Diff::LCS::Internals
Defined in: `lib/diff/lcs/internals.rb`

## Class methods

### .analyze_patchset(patchset, depth = 0)

This method will analyze the provided patchset to provide a single-pass
normalization (conversion of the array form of Diff::LCS::Change objects to
the object form of same) and detection of whether the patchset represents
changes to be made.

### .intuit_diff_direction(src, patchset, limit = nil)

Examine the patchset and the source to see in which direction the
patch should be applied.

WARNING: By default, this examines the whole patch, so this could take
some time. This also works better with Diff::LCS::ContextChange or
Diff::LCS::Change as its source, as an array will cause the creation
of one of the above.

### .inverse_vector(a, vector)

If `vector` maps the matching elements of another collection onto this
Enumerable, compute the inverse of `vector` that maps this Enumerable
onto the collection. (Currently unused.)

### .lcs(a, b)

Compute the longest common subsequence between the sequenced
Enumerables `a` and `b`. The result is an array whose contents is such
that

```
result = Diff::LCS::Internals.lcs(a, b)
result.each_with_index do |e, i|
  assert_equal(a[i], b[e]) unless e.nil?
end
```

### .position_hash(enum, interval)

Returns a hash mapping each element of an Enumerable to the set of
positions it occupies in the Enumerable, optionally restricted to the
elements specified in the range of indexes specified by `interval`.

### .replace_next_larger(enum, value, last_index = nil)

Find the place at which `value` would normally be inserted into the
Enumerable. If that place is already occupied by `value`, do nothing
and return `nil`. If the place does not exist (i.e., it is off the end
of the Enumerable), add it to the end. Otherwise, replace the element
at that point with `value`. It is assumed that the Enumerable's values
are numeric.

This operation preserves the sort order.
