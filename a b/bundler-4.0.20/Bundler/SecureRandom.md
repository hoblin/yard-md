# module Bundler::SecureRandom
Extended by: `Random::Formatter`
Defined in: `lib/bundler/vendor/securerandom/lib/securerandom.rb`

### Secure random number generator interface.

This library is an interface to secure random number generators which are
suitable for generating session keys in HTTP cookies, etc.

You can use this library in your application by requiring it:

```
require 'bundler/vendor/securerandom/lib/securerandom'
```

It supports the following secure random number generators:

* openssl
* /dev/urandom
* Win32

Bundler::SecureRandom is extended by the Random::Formatter module which
defines the following methods:

* alphanumeric
* base64
* choose
* gen_random
* hex
* rand
* random_bytes
* random_number
* urlsafe_base64
* uuid

These methods are usable as class methods of Bundler::SecureRandom such as
`Bundler::SecureRandom.hex`.

If a secure random number generator is not available,
`NotImplementedError` is raised.

## Constants

### VERSION = "0.4.1"

The version

## Class methods

### .bytes(n)

Returns a random binary string containing `size` bytes.

See Random.bytes

## Instance methods

### #alphanumeric(n = nil, chars: ALPHANUMERIC)

Compatibility methods for Ruby 3.2, we can remove this after dropping to support Ruby 3.2
