# class Bundler::URI::RFC3986_Parser
Defined in: `lib/bundler/vendor/uri/lib/uri/rfc3986_parser.rb`

## Constants

### @@to_s = Kernel.instance_method(:to_s)

### FRAGMENT = %r[(?:%\h\h|[!$&-.0-9:;=@A-Z_a-z~/?])*+].source

### HOST

```ruby
HOST = %r[
  (?<IP-literal>\[(?:
      (?<IPv6address>
        (?:\h{1,4}:){6}
        (?<ls32>\h{1,4}:\h{1,4}
        | (?<IPv4address>(?<dec-octet>[1-9]\d|1\d{2}|2[0-4]\d|25[0-5]|\d)
            \.\g<dec-octet>\.\g<dec-octet>\.\g<dec-octet>)
        )
      | ::(?:\h{1,4}:){5}\g<ls32>
      | \h{1,4}?::(?:\h{1,4}:){4}\g<ls32>
      | (?:(?:\h{1,4}:)?\h{1,4})?::(?:\h{1,4}:){3}\g<ls32>
      | (?:(?:\h{1,4}:){,2}\h{1,4})?::(?:\h{1,4}:){2}\g<ls32>
      | (?:(?:\h{1,4}:){,3}\h{1,4})?::\h{1,4}:\g<ls32>
      | (?:(?:\h{1,4}:){,4}\h{1,4})?::\g<ls32>
      | (?:(?:\h{1,4}:){,5}\h{1,4})?::\h{1,4}
      | (?:(?:\h{1,4}:){,6}\h{1,4})?::
      )
    | (?<IPvFuture>v\h++\.[!$&-.0-9:;=A-Z_a-z~]++)
    )\])
| \g<IPv4address>
| (?<reg-name>(?:%\h\h|[!$&-.0-9;=A-Z_a-z~])*+)
]x
```

Bundler::URI defined in RFC3986

### RFC3986_URI

```ruby
RFC3986_URI = %r[\A
(?<seg>#{SEG}){0}
(?<Bundler::URI>
  (?<scheme>#{SCHEME}):
  (?<hier-part>//
    (?<authority>
      (?:(?<userinfo>#{USERINFO.source})@)?
      (?<host>#{HOST.source.delete(" \n")})
      (?::(?<port>\d*+))?
    )
    (?<path-abempty>(?:/\g<seg>*+)?)
  | (?<path-absolute>/((?!/)\g<seg>++)?)
  | (?<path-rootless>(?!/)\g<seg>++)
  | (?<path-empty>)
  )
  (?:\?(?<query>[^\#]*+))?
  (?:\#(?<fragment>#{FRAGMENT}))?
)\z]x
```

### RFC3986_relative_ref

```ruby
RFC3986_relative_ref = %r[\A
(?<seg>#{SEG}){0}
(?<relative-ref>
  (?<relative-part>//
    (?<authority>
      (?:(?<userinfo>#{USERINFO.source})@)?
      (?<host>#{HOST.source.delete(" \n")}(?<!/))?
      (?::(?<port>\d*+))?
    )
    (?<path-abempty>(?:/\g<seg>*+)?)
  | (?<path-absolute>/\g<seg>*+)
  | (?<path-noscheme>#{SEG_NC}++(?:/\g<seg>*+)?)
  | (?<path-empty>)
  )
  (?:\?(?<query>[^#]*+))?
  (?:\#(?<fragment>#{FRAGMENT}))?
)\z]x
```

### SCHEME = %r[[A-Za-z][+\-.0-9A-Za-z]*+].source

### SEG = %r[(?:%\h\h|[!$&-.0-9:;=@A-Z_a-z~/])].source

### SEG_NC = %r[(?:%\h\h|[!$&-.0-9;=@A-Z_a-z~])].source

### USERINFO = /(?:%\h\h|[!$&-.0-9:;=A-Z_a-z~])*+/

## Instance attributes

### #regexp (read-only)

Returns the value of attribute regexp.

## Instance methods

### #escape(str, unsafe = nil)

Compatibility for RFC2396 parser

### #extract(str, schemes = nil, &block)

Compatibility for RFC2396 parser

### #initialize

### #inspect

### #join(*uris)

### #make_regexp(schemes = nil)

Compatibility for RFC2396 parser

### #parse(uri)

### #split(uri)

### #unescape(str, escaped = nil)

Compatibility for RFC2396 parser
