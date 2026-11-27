# class Bundler::SocketAddress
Defined in: `lib/bundler/mirror.rb`

Socket address builder.

Given a socket type, a host and a port,
```
provides a method to build sockaddr string
```

## Instance attributes

### #host (read-only)

Returns the value of attribute host.

### #port (read-only)

Returns the value of attribute port.

### #type (read-only)

Returns the value of attribute type.

## Instance methods

### #initialize(type, host, port)

### #to_socket_address
