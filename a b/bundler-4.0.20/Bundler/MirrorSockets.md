# class Bundler::MirrorSockets
Defined in: `lib/bundler/mirror.rb`

Class used to build the list of sockets that correspond to
```
a given mirror.
```

One mirror may correspond to many different addresses, both
```
because of it having many dns entries or because
the network interface is both ipv4 and ipv5
```

## Instance methods

### #any?

Returns: `Boolean`

### #initialize(mirror)
