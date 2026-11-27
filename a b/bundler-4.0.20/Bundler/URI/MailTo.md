# class Bundler::URI::MailTo < Bundler::URI::Generic
Includes: `Bundler::URI::RFC2396_REGEXP`
Defined in: `lib/bundler/vendor/uri/lib/uri/mailto.rb`

RFC6068, the mailto URL scheme.

## Constants

### COMPONENT = [ :scheme, :to, :headers ].freeze

An Array of the available components for Bundler::URI::MailTo.

### DEFAULT_PORT = nil

A Default port of nil for Bundler::URI::MailTo.

### EMAIL_REGEXP = /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/

practical regexp for email address
https://html.spec.whatwg.org/multipage/input.html#valid-e-mail-address

### HEADER_REGEXP = /\A(?<hfield>(?:%\h\h|[!$'-.0-;@-Z_a-z~])*=(?:%\h\h|[!$'-.0-;@-Z_a-z~])*)(?:&\g<hfield>)*\z/

; RFC 6068
hfields      = "?" hfield *( "&" hfield )
hfield       = hfname "=" hfvalue
hfname       = *qchar
hfvalue      = *qchar
qchar        = unreserved / pct-encoded / some-delims
some-delims  = "!" / "$" / "'" / "(" / ")" / "*"
```
/ "+" / "," / ";" / ":" / "@"
```

; RFC3986
unreserved   = ALPHA / DIGIT / "-" / "." / "_" / "~"
pct-encoded  = "%" HEXDIG HEXDIG

## Instance attributes

### #headers

E-mail headers set by the URL, as an Array of Arrays.

### #to

The primary e-mail address of the URL, as a String.

## Class methods

### .build(args)

##### Description

Creates a new Bundler::URI::MailTo object from components, with syntax checking.

Components can be provided as an Array or Hash. If an Array is used,
the components must be supplied as `[to, headers]`.

If a Hash is used, the keys are the component names preceded by colons.

The headers can be supplied as a pre-encoded string, such as
`"subject=subscribe&cc=address"`, or as an Array of Arrays
like `[['subject', 'subscribe'], ['cc', 'address']]`.

Examples:

```
require 'bundler/vendor/uri/lib/uri'

m1 = Bundler::URI::MailTo.build(['joe@example.com', 'subject=Ruby'])
m1.to_s  # => "mailto:joe@example.com?subject=Ruby"

m2 = Bundler::URI::MailTo.build(['john@example.com', [['Subject', 'Ruby'], ['Cc', 'jack@example.com']]])
m2.to_s  # => "mailto:john@example.com?Subject=Ruby&Cc=jack@example.com"

m3 = Bundler::URI::MailTo.build({:to => 'listman@example.com', :headers => [['subject', 'subscribe']]})
m3.to_s  # => "mailto:listman@example.com?subject=subscribe"
```

## Instance methods

### #initialize(*arg)

##### Description

Creates a new Bundler::URI::MailTo object from generic URL components with
no syntax checking.

This method is usually called from Bundler::URI::parse, which checks
the validity of each component.

### #to_mailtext

Returns the RFC822 e-mail text equivalent of the URL, as a String.

Example:

```
require 'bundler/vendor/uri/lib/uri'

uri = Bundler::URI.parse("mailto:ruby-list@ruby-lang.org?Subject=subscribe&cc=myaddr")
uri.to_mailtext
# => "To: ruby-list@ruby-lang.org\nSubject: subscribe\nCc: myaddr\n\n\n"
```

Also known as: `to_rfc822text`

### #to_s

Constructs String from Bundler::URI.
