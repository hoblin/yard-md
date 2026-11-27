# module Rake::Backtrace
Defined in: `lib/rake/backtrace.rb`

## Constants

### SUPPRESSED_PATHS

```ruby
SUPPRESSED_PATHS = SYS_PATHS.
map { |s| s.tr("\\", "/") }.
map { |f| File.expand_path(f) }.
reject { |s| s.nil? || s =~ /^ *$/ }
```

### SUPPRESSED_PATHS_RE = SUPPRESSED_PATHS.map { |f| Regexp.quote(f) }.join("|")

### SUPPRESS_PATTERN = %r!(\A(#{SUPPRESSED_PATHS_RE})|bin/rake:\d+)!i

### SYS_KEYS = RbConfig::CONFIG.keys.grep(/(?:[a-z]prefix|libdir)\z/)

### SYS_PATHS

```ruby
SYS_PATHS = RbConfig::CONFIG.values_at(*SYS_KEYS).uniq +
[ File.join(File.dirname(__FILE__), "..") ]
```

## Class methods

### .collapse(backtrace)
