# class Bundler::Fetcher::Downloader
Defined in: `lib/bundler/fetcher/downloader.rb`

## Constants

### HTTP_NON_RETRYABLE_ERRORS

```ruby
HTTP_NON_RETRYABLE_ERRORS = [
  SocketError,
  Errno::EADDRNOTAVAIL,
  Errno::ENETDOWN,
  Errno::ENETUNREACH,
  Gem::Net::HTTP::Persistent::Error,
  Errno::EHOSTUNREACH,
].freeze
```

### HTTP_RETRYABLE_ERRORS

```ruby
HTTP_RETRYABLE_ERRORS = [
  Gem::Timeout::Error,
  EOFError,
  Errno::EINVAL,
  Errno::ECONNRESET,
  Errno::ETIMEDOUT,
  Errno::EAGAIN,
  Gem::Net::HTTPBadResponse,
  Gem::Net::HTTPHeaderSyntaxError,
  Gem::Net::ProtocolError,
  Zlib::BufError,
].freeze
```

## Instance attributes

### #connection (read-only)

Returns the value of attribute connection.

### #redirect_limit (read-only)

Returns the value of attribute redirect_limit.

## Instance methods

### #fetch(uri, headers = {}, counter = 0)

Raises: `HTTPError`

### #initialize(connection, redirect_limit)

### #request(uri, headers)
