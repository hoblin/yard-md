# class Diff::LCS::HTMLDiff
Defined in: `lib/diff/lcs/htmldiff.rb`

Produce a simple HTML diff view.

## Constants

### DEFAULT_CSS

```ruby
DEFAULT_CSS = <<-CSS
body { margin: 0; }
.diff
{
border: 1px solid black;
margin: 1em 2em;
}
p
{
margin-left: 2em;
}
pre
{
padding-left: 1em;
margin: 0;
font-family: Inconsolata, Consolas, Lucida, Courier, monospaced;
	white-space: pre;
}
.match { }
.only_a
{
background-color: #fdd;
color: red;
text-decoration: line-through;
}
.only_b
{
background-color: #ddf;
color: blue;
border-left: 3px solid blue
}
h1 { margin-left: 2em; }
CSS
```

standard:disable Layout/HeredocIndentation

### DEFAULT_OPTIONS

```ruby
DEFAULT_OPTIONS = {
  :expand_tabs => nil,
  :output => nil,
  :css => nil,
  :title => nil
}.freeze
```

standard:disable Style/HashSyntax

## Class attributes

### .can_expand_tabs

standard:disable ThreadSafety/ClassAndModuleAttributes

## Instance attributes

### #options (read-only)

Returns the value of attribute options.

## Instance methods

### #initialize(left, right, options = nil)

standard:enable Layout/HeredocIndentation

### #run
