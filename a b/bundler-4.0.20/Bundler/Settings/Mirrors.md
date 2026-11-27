# class Bundler::Settings::Mirrors
Defined in: `lib/bundler/mirror.rb`

Class used to build the mirror set and then find a mirror for a given URI

Parameters:
- `prober` (`Prober object, nil`) — by default a TCPSocketProbe, this object
  will be used to probe the mirror address to validate that the mirror replies.

## Instance methods

### #each

### #for(uri)

Returns a mirror for the given uri.

Depending on the uri having a valid mirror or not, it may be a
```
mirror that points to the provided uri
```

### #initialize(prober = nil)

### #parse(key, value)
