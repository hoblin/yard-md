# class Bundler::Settings::Mirror
Defined in: `lib/bundler/mirror.rb`

A mirror

Contains both the uri that should be used as a mirror and the
```
fallback timeout which will be used for probing if the mirror
replies on time or not.
```

## Constants

### DEFAULT_FALLBACK_TIMEOUT = 0.1

## Instance attributes

### #fallback_timeout

Returns the value of attribute fallback_timeout.

### #uri

Returns the value of attribute uri.

## Instance methods

### #==(other)

### #initialize(uri = nil, fallback_timeout = 0)

### #valid?

Returns: `Boolean`

### #validate!(probe = nil)
