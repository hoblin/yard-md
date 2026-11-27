# class Bundler::ConnectionPool
Includes: `Bundler::ConnectionPool::ForkTracker`
Defined in: `lib/bundler/vendor/connection_pool/lib/connection_pool.rb`

Generic connection pool class for sharing a limited number of objects or network connections
among many threads.  Note: pool elements are lazily created.

Example usage with block (faster):

```
@pool = Bundler::ConnectionPool.new { Redis.new }
@pool.with do |redis|
  redis.lpop('my-list') if redis.llen('my-list') > 0
end
```

Using optional timeout override (for that single invocation)

```
@pool.with(timeout: 2.0) do |redis|
  redis.lpop('my-list') if redis.llen('my-list') > 0
end
```

Example usage replacing an existing connection (slower):

```
$redis = Bundler::ConnectionPool.wrap { Redis.new }

def do_work
  $redis.lpop('my-list') if $redis.llen('my-list') > 0
end
```

Accepts the following options:
- :size - number of connections to pool, defaults to 5
- :timeout - amount of time to wait for a connection if none currently available, defaults to 5 seconds
- :auto_reload_after_fork - automatically drop all connections after fork, defaults to true

## Constants

### DEFAULTS = {size: 5, timeout: 5, auto_reload_after_fork: true}.freeze

### VERSION = "2.5.4"

## Instance attributes

### #auto_reload_after_fork (read-only)

Automatically drop all connections after fork

### #size (read-only)

Size of this connection pool

## Class methods

### .after_fork

### .wrap(options, &block)

## Instance methods

### #available

Number of pool entries available for checkout at this instant.

### #checkin(force: false)

### #checkout(options = {})

### #discard_current_connection {|conn| ... }

Marks the current thread's checked-out connection for discard.

When a connection is marked for discard, it will not be returned to the pool
when checked in. Instead, the connection will be discarded.
This is useful when a connection has become invalid or corrupted
and should not be reused.

Takes an optional block that will be called with the connection to be discarded.
The block should perform any necessary clean-up on the connection.

Note: This only affects the connection currently checked out by the calling thread.
The connection will be discarded when `checkin` is called.

Example:

```ruby
pool.with do |conn|
  begin
    conn.execute("SELECT 1")
  rescue SomeConnectionError
    pool.discard_current_connection  # Mark connection as bad
    raise
  end
end
```

Yields: `conn`

Yield Parameters:
- `conn` (`Object`) — The connection to be discarded.

Yield Returns: `void`

### #idle

Number of pool entries created and idle in the pool.

### #initialize(options = {}, &block)

Raises: `ArgumentError`

### #reap(idle_seconds = 60, &block)

Reaps idle connections that have been idle for over `idle_seconds`.
`idle_seconds` defaults to 60.

### #reload(&block)

Reloads the Bundler::ConnectionPool by passing each connection to `block` and then
removing it the pool. Subsequent checkouts will create new connections as
needed.

### #shutdown(&block)

Shuts down the Bundler::ConnectionPool by passing each connection to `block` and
then removing it from the pool. Attempting to checkout a connection after
shutdown will raise `Bundler::ConnectionPool::PoolShuttingDownError`.

### #with(options = {})

Also known as: `then`
