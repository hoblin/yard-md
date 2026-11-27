# module AST::Sexp
Defined in: `lib/ast/sexp.rb`

This simple module is very useful in the cases where one needs
to define deeply nested ASTs from Ruby code, for example, in
tests. It should be used like this:

```
describe YourLanguage do
  include ::AST::Sexp

  it "should correctly parse expressions" do
    YourLanguage.parse("1 + 2 * 3").should ==
        s(:add,
          s(:integer, 1),
          s(:multiply,
            s(:integer, 2),
            s(:integer, 3)))
  end
end
```

This way the amount of boilerplate code is greatly reduced.

## Instance methods

### #s(type, *children)

Creates a `Node` with type `type` and children `children`.
Note that the resulting node is of the type AST::Node and not a
subclass.
This would not pose a problem with comparisons, as `Node#==`
ignores metadata.
