# module Bundler::URI::RFC2396_REGEXP::PATTERN
Defined in: `lib/bundler/vendor/uri/lib/uri/rfc2396_parser.rb`

Patterns used to parse Bundler::URI's

## Constants

### ALNUM = "#{ALPHA}\\d"

alphanum      = alpha | digit

### ALPHA = "a-zA-Z"

alpha         = lowalpha | upalpha

### DOMLABEL = "(?:[#{ALNUM}](?:[-#{ALNUM}]*[#{ALNUM}])?)"

domainlabel   = alphanum | alphanum *( alphanum | "-" ) alphanum

### ESCAPED = "%[#{HEX}]{2}"

escaped       = "%" hex hex

### HEX = "a-fA-F\\d"

hex           = digit | "A" | "B" | "C" | "D" | "E" | "F" |
```
"a" | "b" | "c" | "d" | "e" | "f"
```

### HOSTNAME = "(?:#{DOMLABEL}\\.)*#{TOPLABEL}\\.?"

hostname      = *( domainlabel "." ) toplabel [ "." ]

### RESERVED = ";/?:@&=+$,\\[\\]"

reserved      = ";" | "/" | "?" | ":" | "@" | "&" | "=" | "+" |
```
"$" | ","
```
reserved      = ";" | "/" | "?" | ":" | "@" | "&" | "=" | "+" |
```
"$" | "," | "[" | "]" (RFC 2732)
```

### TOPLABEL = "(?:[#{ALPHA}](?:[-#{ALNUM}]*[#{ALNUM}])?)"

toplabel      = alpha | alpha *( alphanum | "-" ) alphanum

### UNRESERVED = "\\-_.!~*'()#{ALNUM}"

mark          = "-" | "_" | "." | "!" | "~" | "*" | "'" |
```
"(" | ")"
```
unreserved    = alphanum | mark
