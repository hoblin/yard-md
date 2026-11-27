# module Bundler::YAMLSerializer
Defined in: `lib/bundler/yaml_serializer.rb`

A stub yaml serializer that can handle only hashes and strings (as of now).

## Constants

### ARRAY_REGEX

```ruby
ARRAY_REGEX = /
  ^
  (?:[ ]*-[ ]) # '- ' before array items
  (['"]?) # optional opening quote
  (.*) # value
  \1 # matching closing quote
  $
/xo
```

### HASH_REGEX

```ruby
HASH_REGEX = /
  ^
  ([ ]*) # indentations
  ([^#]+) # key excludes comment char '#'
  (?::(?=(?:\s|$))) # :  (without the lookahead the #key includes this when : is present in value)
  [ ]?
  (['"]?) # optional opening quote
  (.*) # value
  \3 # matching closing quote
  $
/xo
```

## Class methods

### .dump(hash)

### .dump_hash(hash)

### .load(str)

### .strip_comment(val)
