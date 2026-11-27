# class Bundler::Thor::Option < Bundler::Thor::Argument
Defined in: `lib/bundler/vendor/thor/lib/thor/parser/option.rb`

## Constants

### VALID_TYPES = [:boolean, :numeric, :hash, :array, :string]

## Instance attributes

### #aliases (read-only)

Returns the value of attribute aliases.

### #group (read-only)

Returns the value of attribute group.

### #hide (read-only)

Returns the value of attribute hide.

### #lazy_default (read-only)

Returns the value of attribute lazy_default.

### #repeatable (read-only)

Returns the value of attribute repeatable.

## Class methods

### .parse(key, value)

This parse quick options given as method_options. It makes several
assumptions, but you can be more specific using the option method.

```
parse :foo => "bar"
#=> Option foo with default value bar

parse [:foo, :baz] => "bar"
#=> Option foo with default value bar and alias :baz

parse :foo => :required
#=> Required option foo without default value

parse :foo => 2
#=> Option foo with default value 2 and type numeric

parse :foo => :numeric
#=> Option foo without default value and type numeric

parse :foo => true
#=> Option foo with default value true and type boolean
```

The valid types are :boolean, :numeric, :hash, :array and :string. If none
is given a default type is assumed. This default type accepts arguments as
string (--foo=value) or booleans (just --foo).

By default all options are optional, unless :required is given.

## Instance methods

### #aliases_for_usage

### #human_name

### #initialize(name, options = {})

### #show_default?

Returns: `Boolean`

### #switch_name

### #usage(padding = 0)
