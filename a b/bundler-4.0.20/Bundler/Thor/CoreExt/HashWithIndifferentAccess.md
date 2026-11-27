# class Bundler::Thor::CoreExt::HashWithIndifferentAccess < Hash
Defined in: `lib/bundler/vendor/thor/lib/thor/core_ext/hash_with_indifferent_access.rb`

A hash with indifferent access and magic predicates.

```
hash = Bundler::Thor::CoreExt::HashWithIndifferentAccess.new 'foo' => 'bar', 'baz' => 'bee', 'force' => true

hash[:foo]  #=> 'bar'
hash['foo'] #=> 'bar'
hash.foo?   #=> true
```

## Instance methods

### #[](key)

### #[]=(key, value)

### #delete(key)

### #except(*keys)

### #fetch(key, *args)

### #initialize(hash = {})

### #key?(key)

Returns: `Boolean`

### #merge(other)

### #merge!(other)

### #replace(other_hash)

### #reverse_merge(other)

### #reverse_merge!(other_hash)

### #slice(*keys)

### #to_hash

Convert to a Hash with String keys.

### #values_at(*indices)
