# class Bundler::URI::LDAP < Bundler::URI::Generic
Defined in: `lib/bundler/vendor/uri/lib/uri/ldap.rb`

LDAP Bundler::URI SCHEMA (described in RFC2255).
--
ldap://<host>/<dn>[?<attrs>[?<scope>[?<filter>[?<extensions>]]]]
++

## Constants

### COMPONENT

```ruby
COMPONENT = [
  :scheme,
  :host, :port,
  :dn,
  :attributes,
  :scope,
  :filter,
  :extensions,
].freeze
```

An Array of the available components for Bundler::URI::LDAP.

### DEFAULT_PORT = 389

A Default port of 389 for Bundler::URI::LDAP.

### SCOPE

```ruby
SCOPE = [
  SCOPE_ONE = 'one',
  SCOPE_SUB = 'sub',
  SCOPE_BASE = 'base',
].freeze
```

Scopes available for the starting point.

* SCOPE_BASE - the Base DN
* SCOPE_ONE  - one level under the Base DN, not including the base DN and
  not including any entries under this
* SCOPE_SUB  - subtrees, all entries at all levels

## Class methods

### .build(args)

##### Description

Creates a new Bundler::URI::LDAP object from components, with syntax checking.

The components accepted are host, port, dn, attributes,
scope, filter, and extensions.

The components should be provided either as an Array, or as a Hash
with keys formed by preceding the component names with a colon.

If an Array is used, the components must be passed in the
order `[host, port, dn, attributes, scope, filter, extensions]`.

Example:

```
uri = Bundler::URI::LDAP.build({:host => 'ldap.example.com',
  :dn => '/dc=example'})

uri = Bundler::URI::LDAP.build(["ldap.example.com", nil,
  "/dc=example;dc=com", "query", nil, nil, nil])
```

## Instance methods

### #attributes

Returns attributes.

### #attributes=(val)

Setter for attributes `val`.

### #dn

Returns dn.

### #dn=(val)

Setter for dn `val`.

### #extensions

Returns extensions.

### #extensions=(val)

Setter for extensions `val`.

### #filter

Returns filter.

### #filter=(val)

Setter for filter `val`.

### #hierarchical?

Checks if Bundler::URI has a path.
For Bundler::URI::LDAP this will return `false`.

Returns: `Boolean`

### #initialize(*arg)

##### Description

Creates a new Bundler::URI::LDAP object from generic Bundler::URI components as per
RFC 2396. No LDAP-specific syntax checking is performed.

Arguments are `scheme`, `userinfo`, `host`, `port`, `registry`, `path`,
`opaque`, `query`, and `fragment`, in that order.

Example:

```
uri = Bundler::URI::LDAP.new("ldap", nil, "ldap.example.com", nil, nil,
  "/dc=example;dc=com", nil, "query", nil)
```

See also Bundler::URI::Generic.new.

### #scope

Returns scope.

### #scope=(val)

Setter for scope `val`.
