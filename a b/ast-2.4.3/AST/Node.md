# class AST::Node
Defined in: `lib/ast/node.rb`

Node is an immutable class, instances of which represent abstract
syntax tree nodes. It combines semantic information (i.e. anything
that affects the algorithmic properties of a program) with
meta-information (line numbers or compiler intermediates).

Notes on inheritance
###### 

The distinction between semantics and metadata is important. Complete
semantic information should be contained within just the `#type` and
`#children` of a Node instance; in other words, if an AST was to be
stripped of all meta-information, it should remain a valid AST which
could be successfully processed to yield a result with the same
algorithmic properties.

Thus, Node should never be inherited in order to define methods which
affect or return semantic information, such as getters for `class_name`,
`superclass` and `body` in the case of a hypothetical `ClassNode`. The
correct solution is to use a generic Node with a `#type` of `:class`
and three children. See also `Processor` for tips on working with such
ASTs.

On the other hand, Node can and should be inherited to define
application-specific metadata (see also `#initialize`) or customize the
printing format. It is expected that an application would have one or two
such classes and use them across the entire codebase.

The rationale for this pattern is extensibility and maintainability.
Unlike static ones, dynamic languages do not require the presence of a
predefined, rigid structure, nor does it improve dispatch efficiency,
and while such a structure can certainly be defined, it does not add
any value but incurs a maintaining cost.
For example, extending the AST even with a transformation-local
temporary node type requires making globally visible changes to
the codebase.

## Instance attributes

### #children (read-only)

Returns the children of this node.
The returned value is frozen.
The to_a alias is useful for decomposing nodes concisely.
For example:

```
node = s(:gasgn, :$foo, s(:integer, 1))
var_name, value = *node
p var_name # => :$foo
p value    # => (integer 1)
```

Returns: `Array`

Also known as: `to_a`

### #hash (read-only)

Returns the precomputed hash value for this node

Returns: `Integer`

### #type (read-only)

Returns the type of this node.

Returns: `Symbol`

## Instance methods

### #==(other)

Compares `self` to `other`, possibly converting with `to_ast`. Only
`type` and `children` are compared; metadata is deliberately ignored.

Returns: `Boolean`

### #append(element)

Appends `element` to `children` and returns the resulting node.

Returns: `AST::Node`

Also known as: `<<`

### #concat(array)

Concatenates `array` with `children` and returns the resulting node.

Returns: `AST::Node`

Also known as: `+`

### #deconstruct

Enables matching for Node, where type is the first element
and the children are remaining items.

Returns: `Array`

### #dup

Nodes are already frozen, so there is no harm in returning the
current node as opposed to initializing from scratch and freezing
another one.

Returns: self

Also known as: `clone`

### #eql?(other)

Test if other object is equal to

Parameters:
- `other` (`Object`)

Returns: `Boolean`

### #initialize(type, children = [], properties = {})

Constructs a new instance of Node.

The arguments `type` and `children` are converted with `to_sym` and
`to_a` respectively. Additionally, the result of converting `children`
is frozen. While mutating the arguments is generally considered harmful,
the most common case is to pass an array literal to the constructor. If
your code does not expect the argument to be frozen, use `#dup`.

The `properties` hash is passed to `#assign_properties`.

### #inspect(indent = 0)

Converts `self` to a s-expression ruby string.
The code return will recreate the node, using the sexp module s()

Parameters:
- `indent` (`Integer`) — Base indentation level.

Returns: `String`

### #to_ast

Returns: `AST::Node` — self

### #to_sexp(indent = 0)

Converts `self` to a pretty-printed s-expression.

Parameters:
- `indent` (`Integer`) — Base indentation level.

Returns: `String`

Also known as: `to_s`

### #to_sexp_array

Converts `self` to an Array where the first element is the type as a Symbol,
and subsequent elements are the same representation of its children.

Returns: `Array<Symbol, [...Array]>`

### #updated(type = nil, children = nil, properties = nil)

Returns a new instance of Node where non-nil arguments replace the
corresponding fields of `self`.

For example, `Node.new(:foo, [ 1, 2 ]).updated(:bar)` would yield
`(bar 1 2)`, and `Node.new(:foo, [ 1, 2 ]).updated(nil, [])` would
yield `(foo)`.

If the resulting node would be identical to `self`, does nothing.

Parameters:
- `type` (`Symbol, nil`)
- `children` (`Array, nil`)
- `properties` (`Hash, nil`)

Returns: `AST::Node`
