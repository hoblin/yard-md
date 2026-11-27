# class Bundler::CurrentRuby
Defined in: `lib/bundler/current_ruby.rb`

## Constants

### ALL_RUBY_VERSIONS = [*18..27, *30..34, *40..41].freeze

### KNOWN_MAJOR_VERSIONS = ALL_RUBY_VERSIONS.map {|v| v.digits.last.to_s }.uniq.freeze

### KNOWN_MINOR_VERSIONS = ALL_RUBY_VERSIONS.map {|v| v.digits.reverse.join(".") }.freeze

### PLATFORM_MAP

```ruby
PLATFORM_MAP = {
  ruby: [Gem::Platform::RUBY, CurrentRuby::ALL_RUBY_VERSIONS],
  mri: [Gem::Platform::RUBY, CurrentRuby::ALL_RUBY_VERSIONS],
  rbx: [Gem::Platform::RUBY],
  truffleruby: [Gem::Platform::RUBY],
  jruby: [Gem::Platform::JAVA, [18, 19]],
  windows: [Gem::Platform::WINDOWS, CurrentRuby::ALL_RUBY_VERSIONS],
  # deprecated
  mswin: [Gem::Platform::MSWIN, CurrentRuby::ALL_RUBY_VERSIONS],
  mswin64: [Gem::Platform::MSWIN64, CurrentRuby::ALL_RUBY_VERSIONS - [18]],
  mingw: [Gem::Platform::UNIVERSAL_MINGW, CurrentRuby::ALL_RUBY_VERSIONS],
  x64_mingw: [Gem::Platform::UNIVERSAL_MINGW, CurrentRuby::ALL_RUBY_VERSIONS - [18, 19]],
}.each_with_object({}) do |(platform, spec), hash|
  hash[platform] = spec[0]
  spec[1]&.each {|version| hash[:"#{platform}_#{version}"] = spec[0] }
end.freeze
```

## Instance methods

### #jruby?

Returns: `Boolean`

### #maglev?

Returns: `Boolean`

### #mri?

Returns: `Boolean`

### #rbx?

Returns: `Boolean`

### #ruby?

Returns: `Boolean`

### #truffleruby?

Returns: `Boolean`

### #windows?

Returns: `Boolean`

Also known as: `mswin?`, `mswin64?`, `mingw?`, `x64_mingw?`
