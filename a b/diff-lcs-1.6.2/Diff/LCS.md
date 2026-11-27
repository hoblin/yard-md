# module Diff::LCS
Defined in: `lib/diff/lcs.rb`

### How Diff Works (by Mark-Jason Dominus)

I once read an article written by the authors of `diff`; they said that they
hard worked very hard on the algorithm until they found the right one.

I think what they ended up using (and I hope someone will correct me, because
I am not very confident about this) was the `longest common subsequence'
method. In the LCS problem, you have two sequences of items:

```
a b c d f g h j q z
a b c d e f g i j k r x y z
```

and you want to find the longest sequence of items that is present in both
original sequences in the same order. That is, you want to find a new
sequence **S** which can be obtained from the first sequence by deleting some
items, and from the second sequence by deleting other items. You also want
**S** to be as long as possible. In this case **S** is:

```
a b c d f g j z
```

From there it's only a small step to get diff-like output:

```
e   h i   k   q r x y
+   - +   +   - + + +
```

This module solves the LCS problem. It also includes a canned function to
generate `diff`-like output.

It might seem from the example above that the LCS of two sequences is always
pretty obvious, but that's not always the case, especially when the two
sequences have many repeated elements. For example, consider

```
a x b y c z p d q
a b c a x b y c z
```

A naive approach might start by matching up the `a` and `b` that appear at
the beginning of each sequence, like this:

```
a x b y c         z p d q
a   b   c a b y c z
```

This finds the common subsequence +a b c z+. But actually, the LCS is +a x b
y c z+:

```
      a x b y c z p d q
a b c a x b y c z
```

## Constants

### BalancedCallbacks = DefaultCallbacks

An alias for DefaultCallbacks that is used in
Diff::LCS#traverse_balanced.

```
Diff::LCS.LCS(seq1, seq2, Diff::LCS::BalancedCallbacks)
```

### PATCH_MAP

```ruby
PATCH_MAP = { # :nodoc:
  :patch => {"+" => "+", "-" => "-", "!" => "!", "=" => "="}.freeze,
  :unpatch => {"+" => "-", "-" => "+", "!" => "!", "=" => "="}.freeze
}.freeze
```

standard:disable Style/HashSyntax

### SequenceCallbacks = DefaultCallbacks

An alias for DefaultCallbacks that is used in
Diff::LCS#traverse_sequences.

```
Diff::LCS.LCS(seq1, seq2, Diff::LCS::SequenceCallbacks)
```

### VERSION = "1.6.2"

## Class methods

### .callbacks_for(callbacks)

### .diff(seq1, seq2, callbacks = nil, &block)

#diff computes the smallest set of additions and deletions necessary to
turn the first sequence into the second, and returns a description of these
changes.

See Diff::LCS::DiffCallbacks for the default behaviour. An alternate
behaviour may be implemented with Diff::LCS::ContextDiffCallbacks. If a
Class argument is provided for `callbacks`, #diff will attempt to
initialise it. If the `callbacks` object (possibly initialised) responds to
#finish, it will be called.

### .diff_traversal(method, seq1, seq2, callbacks, &block)

### .lcs(seq1, seq2, &block)

:yields: seq1[i] for each matched

Also known as: `LCS`

### .patch(src, patchset, direction = nil)

Applies a `patchset` to the sequence `src` according to the `direction`
(`:patch` or `:unpatch`), producing a new sequence.

If the `direction` is not specified, Diff::LCS::patch will attempt to
discover the direction of the `patchset`.

A `patchset` can be considered to apply forward (`:patch`) if the
following expression is true:

```
patch(s1, diff(s1, s2)) -> s2
```

A `patchset` can be considered to apply backward (`:unpatch`) if the
following expression is true:

```
patch(s2, diff(s1, s2)) -> s1
```

If the `patchset` contains no changes, the `src` value will be returned as
either `src.dup` or `src`. A `patchset` can be deemed as having no
changes if the following predicate returns true:

```
patchset.empty? or
  patchset.flatten(1).all? { |change| change.unchanged? }
```

###### Patchsets

A `patchset` is always an enumerable sequence of changes, hunks of changes,
or a mix of the two. A hunk of changes is an enumerable sequence of
changes:

```
[ # patchset
  # change
  [ # hunk
    # change
  ]
]
```

The `patch` method accepts `patchset`s that are enumerable sequences
containing either Diff::LCS::Change objects (or a subclass) or the array
representations of those objects. Prior to application, array
representations of Diff::LCS::Change objects will be reified.

### .patch!(src, patchset)

Given a set of patchset, convert the current version to the next version.
Does no auto-discovery.

### .sdiff(seq1, seq2, callbacks = nil, &block)

#sdiff computes all necessary components to show two sequences and their
minimized differences side by side, just like the Unix utility
*sdiff* does:

```
old        <     -
same             same
before     |     after
-          >     new
```

See Diff::LCS::SDiffCallbacks for the default behaviour. An alternate
behaviour may be implemented with Diff::LCS::ContextDiffCallbacks. If a
Class argument is provided for `callbacks`, #diff will attempt to
initialise it. If the `callbacks` object (possibly initialised) responds to
#finish, it will be called.

Each element of a returned array is a Diff::LCS::ContextChange object,
which can be implicitly converted to an array.

```
Diff::LCS.sdiff(a, b).each do |action, (old_pos, old_element), (new_pos, new_element)|
  case action
  when '!'
    # replace
  when '-'
    # delete
  when '+'
    # insert
  end
end
```

### .traverse_balanced(seq1, seq2, callbacks = Diff::LCS::BalancedCallbacks)

#traverse_balanced is an alternative to #traverse_sequences. It uses a
different algorithm to iterate through the entries in the computed longest
common subsequence. Instead of viewing the changes as insertions or
deletions from one of the sequences, #traverse_balanced will report
*changes* between the sequences.

The arguments to #traverse_balanced are the two sequences to traverse and a
callback object, like this:

```
traverse_balanced(seq1, seq2, Diff::LCS::ContextDiffCallbacks.new)
```

#sdiff is implemented with #traverse_balanced.

##### Callback Methods

Optional callback methods are *emphasized*.

**callbacks#match** — Called when `a` and `b` are pointing to
                                common elements in `A` and `B`.
**callbacks#discard_a** — Called when `a` is pointing to an
                                element not in `B`.
**callbacks#discard_b** — Called when `b` is pointing to an
                                element not in `A`.
***callbacks#change*** — Called when `a` and `b` are pointing to
                                the same relative position, but
                                `A[a]` and `B[b]` are not
                                the same; a *change* has
                                occurred.

#traverse_balanced might be a bit slower than #traverse_sequences,
noticeable only while processing huge amounts of data.

##### Algorithm

```
a---+
    v
A = a b c e h j l m n p
B = b c d e f j k l m r s t
    ^
b---+
```

###### Matches

If there are two arrows (`a` and `b`) pointing to elements of sequences `A`
and `B`, the arrows will initially point to the first elements of their
respective sequences. #traverse_sequences will advance the arrows through
the sequences one element at a time, calling a method on the user-specified
callback object before each advance. It will advance the arrows in such a
way that if there are elements `A[i]` and `B[j]` which are
both equal and part of the longest common subsequence, there will be some
moment during the execution of #traverse_sequences when arrow `a` is
pointing to `A[i]` and arrow `b` is pointing to `B[j]`. When
this happens, #traverse_sequences will call `callbacks#match` and
then it will advance both arrows.

###### Discards

Otherwise, one of the arrows is pointing to an element of its sequence that
is not part of the longest common subsequence. #traverse_sequences will
advance that arrow and will call `callbacks#discard_a` or
`callbacks#discard_b`, depending on which arrow it advanced.

###### Changes

If both `a` and `b` point to elements that are not part of the longest
common subsequence, then #traverse_sequences will try to call
`callbacks#change` and advance both arrows. If
`callbacks#change` is not implemented, then
`callbacks#discard_a` and `callbacks#discard_b` will be
called in turn.

The methods for `callbacks#match`, `callbacks#discard_a`,
`callbacks#discard_b`, and `callbacks#change` are invoked
with an event comprising the action ("=", "+", "-", or "!", respectively),
the indexes `i` and `j`, and the elements `A[i]` and `B[j]`.
Return values are discarded by #traverse_balanced.

###### Context

Note that `i` and `j` may not be the same index position, even if `a` and
`b` are considered to be pointing to matching or changed elements.

### .traverse_sequences(seq1, seq2, callbacks = Diff::LCS::SequenceCallbacks)

#traverse_sequences is the most general facility provided by this module;
#diff and #lcs are implemented as calls to it.

The arguments to #traverse_sequences are the two sequences to traverse, and
a callback object, like this:

```
traverse_sequences(seq1, seq2, Diff::LCS::ContextDiffCallbacks.new)
```

##### Callback Methods

Optional callback methods are *emphasized*.

**callbacks#match** — Called when `a` and `b` are pointing to
                                common elements in `A` and `B`.
**callbacks#discard_a** — Called when `a` is pointing to an
                                element not in `B`.
**callbacks#discard_b** — Called when `b` is pointing to an
                                element not in `A`.
***callbacks#finished_a*** — Called when `a` has reached the end of
                                sequence `A`.
***callbacks#finished_b*** — Called when `b` has reached the end of
                                sequence `B`.

##### Algorithm

```
a---+
    v
A = a b c e h j l m n p
B = b c d e f j k l m r s t
    ^
b---+
```

If there are two arrows (`a` and `b`) pointing to elements of sequences `A`
and `B`, the arrows will initially point to the first elements of their
respective sequences. #traverse_sequences will advance the arrows through
the sequences one element at a time, calling a method on the user-specified
callback object before each advance. It will advance the arrows in such a
way that if there are elements `A[i]` and `B[j]` which are
both equal and part of the longest common subsequence, there will be some
moment during the execution of #traverse_sequences when arrow `a` is
pointing to `A[i]` and arrow `b` is pointing to `B[j]`. When
this happens, #traverse_sequences will call `callbacks#match` and
then it will advance both arrows.

Otherwise, one of the arrows is pointing to an element of its sequence that
is not part of the longest common subsequence. #traverse_sequences will
advance that arrow and will call `callbacks#discard_a` or
`callbacks#discard_b`, depending on which arrow it advanced. If both
arrows point to elements that are not part of the longest common
subsequence, then #traverse_sequences will advance arrow `a` and call the
appropriate callback, then it will advance arrow `b` and call the appropriate
callback.

The methods for `callbacks#match`, `callbacks#discard_a`, and
`callbacks#discard_b` are invoked with an event comprising the
action ("=", "+", or "-", respectively), the indexes `i` and `j`, and the
elements `A[i]` and `B[j]`. Return values are discarded by
#traverse_sequences.

###### End of Sequences

If arrow `a` reaches the end of its sequence before arrow `b` does,
#traverse_sequence will try to call `callbacks#finished_a` with the
last index and element of `A` (`A[-1]`) and the current index and
element of `B` (`B[j]`). If `callbacks#finished_a` does not
exist, then `callbacks#discard_b` will be called on each element of
`B` until the end of the sequence is reached (the call will be done with
`A[-1]` and `B[j]` for each element).

If `b` reaches the end of `B` before `a` reaches the end of `A`,
`callbacks#finished_b` will be called with the current index and
element of `A` (`A[i]`) and the last index and element of `B`
(`A[-1]`). Again, if `callbacks#finished_b` does not exist on
the callback object, then `callbacks#discard_a` will be called on
each element of `A` until the end of the sequence is reached (`A[i]`
and `B[-1]`).

There is a chance that one additional `callbacks#discard_a` or
`callbacks#discard_b` will be called after the end of the sequence
is reached, if `a` has not yet reached the end of `A` or `b` has not yet
reached the end of `B`.

### .unpatch!(src, patchset)

Given a set of patchset, convert the current version to the prior version.
Does no auto-discovery.

## Instance methods

### #diff(other, callbacks = nil, &block)

Returns the difference set between `self` and `other`. See Diff::LCS#diff.

### #lcs(other, &block)

Returns an Array containing the longest common subsequence(s) between
`self` and `other`. See Diff::LCS#lcs.

```
lcs = seq1.lcs(seq2)
```

A note when using objects: Diff::LCS only works properly when each object
can be used as a key in a Hash. This means that those objects must implement
the methods `#hash` and `#eql?` such that two objects containing identical values
compare identically for key purposes. That is:

```
O.new('a').eql?(O.new('a')) == true &&
O.new('a').hash == O.new('a').hash
```

### #patch(patchset)

Attempts to patch `self` with the provided `patchset`. A new sequence based
on `self` and the `patchset` will be created. See Diff::LCS#patch. Attempts
to autodiscover the direction of the patch.

### #patch!(patchset)

Attempts to patch `self` with the provided `patchset`. A new sequence based
on `self` and the `patchset` will be created. See Diff::LCS#patch. Does no
patch direction autodiscovery.

### #patch_me(patchset)

Attempts to patch `self` with the provided `patchset`, using #patch!. If
the sequence this is used on supports #replace, the value of `self` will be
replaced. See Diff::LCS#patch. Does no patch direction autodiscovery.

### #sdiff(other, callbacks = nil, &block)

Returns the balanced ("side-by-side") difference set between `self` and
`other`. See Diff::LCS#sdiff.

### #traverse_balanced(other, callbacks = nil, &block)

Traverses the discovered longest common subsequences between `self` and
`other` using the alternate, balanced algorithm. See
Diff::LCS#traverse_balanced.

### #traverse_sequences(other, callbacks = nil, &block)

Traverses the discovered longest common subsequences between `self` and
`other`. See Diff::LCS#traverse_sequences.

### #unpatch

Attempts to patch `self` with the provided `patchset`. A new sequence based
on `self` and the `patchset` will be created. See Diff::LCS#patch. Attempts
to autodiscover the direction of the patch.

### #unpatch!(patchset)

Attempts to unpatch `self` with the provided `patchset`. A new sequence
based on `self` and the `patchset` will be created. See Diff::LCS#unpatch.
Does no patch direction autodiscovery.

### #unpatch_me(patchset)

Attempts to unpatch `self` with the provided `patchset`, using #unpatch!.
If the sequence this is used on supports #replace, the value of `self` will
be replaced. See Diff::LCS#unpatch. Does no patch direction autodiscovery.
