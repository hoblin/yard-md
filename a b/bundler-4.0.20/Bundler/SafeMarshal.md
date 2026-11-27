# module Bundler::SafeMarshal
Defined in: `lib/bundler/safe_marshal.rb`

## Constants

### ALLOWED_CLASSES

```ruby
ALLOWED_CLASSES = [
  Array,
  FalseClass,
  Gem::Specification,
  Gem::Version,
  Hash,
  String,
  Symbol,
  Time,
  TrueClass,
].freeze
```

### ERROR = "Unexpected class %s present in marshaled data. Only %s are allowed."

### PROC

```ruby
PROC = proc do |object|
  object.tap do
    unless ALLOWED_CLASSES.include?(object.class)
      raise TypeError, format(ERROR, object.class, ALLOWED_CLASSES.join(", "))
    end
  end
end
```

## Class methods

### .proc
