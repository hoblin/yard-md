# class Bundler::Fetcher
Defined in: `lib/bundler/fetcher.rb`

Handles all the fetching with the rubygems server

## Constants

### FAIL_ERRORS

```ruby
FAIL_ERRORS = [
  AuthenticationRequiredError,
  BadAuthenticationError,
  AuthenticationForbiddenError,
  FallbackError,
  SecurityError,
  Gem::Requirement::BadRequirementError,
  Gem::Net::HTTPBadGateway,
  Gem::Net::HTTPBadRequest,
  Gem::Net::HTTPFailedDependency,
  Gem::Net::HTTPForbidden,
  Gem::Net::HTTPInsufficientStorage,
  Gem::Net::HTTPMethodNotAllowed,
  Gem::Net::HTTPMovedPermanently,
  Gem::Net::HTTPNoContent,
  Gem::Net::HTTPNotFound,
  Gem::Net::HTTPNotImplemented,
  Gem::Net::HTTPPreconditionFailed,
  Gem::Net::HTTPRequestEntityTooLarge,
  Gem::Net::HTTPRequestURITooLong,
  Gem::Net::HTTPUnauthorized,
  Gem::Net::HTTPUnprocessableEntity,
  Gem::Net::HTTPUnsupportedMediaType,
  Gem::Net::HTTPVersionNotSupported,
].freeze
```

Exceptions classes that should bypass retry attempts. If your password didn't work the
first time, it's not going to the third time.

### HTTP_ERRORS = (Downloader::HTTP_RETRYABLE_ERRORS + Downloader::HTTP_NON_RETRYABLE_ERRORS).freeze

### NET_ERRORS

```ruby
NET_ERRORS = [
  :HTTPBadGateway,
  :HTTPBadRequest,
  :HTTPFailedDependency,
  :HTTPForbidden,
  :HTTPInsufficientStorage,
  :HTTPMethodNotAllowed,
  :HTTPMovedPermanently,
  :HTTPNoContent,
  :HTTPNotFound,
  :HTTPNotImplemented,
  :HTTPPreconditionFailed,
  :HTTPRequestEntityTooLarge,
  :HTTPRequestURITooLong,
  :HTTPUnauthorized,
  :HTTPUnprocessableEntity,
  :HTTPUnsupportedMediaType,
  :HTTPVersionNotSupported,
].freeze
```

## Class attributes

### .api_timeout

Returns the value of attribute api_timeout.

### .disable_endpoint

Returns the value of attribute disable_endpoint.

### .max_retries

Returns the value of attribute max_retries.

### .redirect_limit

Returns the value of attribute redirect_limit.

## Instance methods

### #api_fetcher?

Returns: `Boolean`

### #fetch_spec(spec)

fetch a gem specification

### #gem_remote_fetcher

### #http_proxy

### #initialize(remote)

### #inspect

### #release_resolution_memory!

### #specs(gem_names, source)

return the specs in the bundler format as an index

### #specs_with_retry(gem_names, source)

return the specs in the bundler format as an index with retries

### #uri

### #user_agent
