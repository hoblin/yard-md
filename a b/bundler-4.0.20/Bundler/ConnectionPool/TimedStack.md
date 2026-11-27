# class Bundler::ConnectionPool::TimedStack
Defined in: `lib/bundler/vendor/connection_pool/lib/connection_pool/timed_stack.rb`

The TimedStack manages a pool of homogeneous connections (or any resource
you wish to manage). Connections are created lazily up to a given maximum
number.

Examples:

```
ts = TimedStack.new(1) { MyConnection.new }

# fetch a connection
conn = ts.pop

# return a connection
ts.push conn

conn = ts.pop
ts.pop timeout: 5
#=> raises Bundler::ConnectionPool::TimeoutError after 5 seconds
```

## Instance attributes

### #max (read-only)

Returns the value of attribute max.

## Instance methods

### #decrement_created

Reduce the created count

### #empty?

Returns `true` if there are no available connections.

Returns: `Boolean`

### #idle

The number of connections created and available on the stack.

### #initialize(size = 0, &block)

Creates a new pool with `size` connections that are created from the given
`block`.

### #length

The number of connections available on the stack.

### #pop(timeout = 0.5, options = {})

Retrieves a connection from the stack. If a connection is available it is
immediately returned. If no connection is available within the given
timeout a Bundler::ConnectionPool::TimeoutError is raised.

`:timeout` is the only checked entry in `options` and is preferred over
the `timeout` argument (which will be removed in a future release). Other
options may be used by subclasses that extend TimedStack.

### #push(obj, options = {})

Returns `obj` to the stack. `options` is ignored in TimedStack but may be
used by subclasses that extend TimedStack.

Also known as: `<<`

### #reap(idle_seconds, &block)

Reaps connections that were checked in more than `idle_seconds` ago.

Raises: `ArgumentError`

### #shutdown(reload: false, &block)

Shuts down the TimedStack by passing each connection to `block` and then
removing it from the pool. Attempting to checkout a connection after
shutdown will raise `Bundler::ConnectionPool::PoolShuttingDownError` unless
`:reload` is `true`.

Raises: `ArgumentError`
