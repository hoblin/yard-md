# class Bundler::URI::File < Bundler::URI::Generic
Defined in: `lib/bundler/vendor/uri/lib/uri/file.rb`

The "file" Bundler::URI is defined by RFC8089.

## Constants

### COMPONENT

```ruby
COMPONENT = [
  :scheme,
  :host,
  :path
].freeze
```

An Array of the available components for Bundler::URI::File.

### DEFAULT_PORT = nil

A Default port of nil for Bundler::URI::File.

## Class methods

### .build(args)

##### Description

Creates a new Bundler::URI::File object from components, with syntax checking.

The components accepted are `host` and `path`.

The components should be provided either as an Array, or as a Hash
with keys formed by preceding the component names with a colon.

If an Array is used, the components must be passed in the
order `[host, path]`.

A path from e.g. the File class should be escaped before
being passed.

Examples:

```
require 'bundler/vendor/uri/lib/uri'

uri1 = Bundler::URI::File.build(['host.example.com', '/path/file.zip'])
uri1.to_s  # => "file://host.example.com/path/file.zip"

uri2 = Bundler::URI::File.build({:host => 'host.example.com',
  :path => '/ruby/src'})
uri2.to_s  # => "file://host.example.com/ruby/src"

uri3 = Bundler::URI::File.build({:path => Bundler::URI::RFC2396_PARSER.escape('/path/my file.txt')})
uri3.to_s  # => "file:///path/my%20file.txt"
```

## Instance methods

### #check_password(user)

raise InvalidURIError

Raises: `Bundler::URI::InvalidURIError`

### #check_user(user)

raise InvalidURIError

Raises: `Bundler::URI::InvalidURIError`

### #check_userinfo(user)

raise InvalidURIError

Raises: `Bundler::URI::InvalidURIError`

### #set_host(v)

Protected setter for the host component `v`.

See also Bundler::URI::Generic.host=.

### #set_password(v)

do nothing

### #set_port(v)

do nothing

### #set_user(v)

do nothing

### #set_userinfo(v)

do nothing
