# Top-level namespace

## Instance methods

### #gemfile(force_latest_compatible = false, options = {}, &gemfile)

Allows for declaring a Gemfile inline in a ruby script, installing any gems
that aren't already installed on the user's system.

Note: Every gem that is specified in this 'Gemfile' will be `require`d, as if
  the user had manually called `Bundler.require`. To avoid a requested gem
  being automatically required, add the `:require => false` option to the
  `gem` dependency declaration.

Example: Using an inline Gemfile

```ruby
#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'json', require: false
  gem 'nap', require: 'rest'
  gem 'cocoapods', '~> 0.34.1'
end

puts Pod::VERSION # => "0.34.4"
```

Parameters:
- `force_latest_compatible` (`Boolean`) — Force installing the **latest**
  compatible versions of the gems,
  even if compatible versions are
  already installed locally.
  This also logs output if the
  `:quiet` option is not set.
  Defaults to `false`.
- `gemfile` (`Proc`) — a block that is evaluated as a `Gemfile`.

Raises: `ArgumentError`
