# class Bundler::Thor::Command < Struct
Defined in: `lib/bundler/vendor/thor/lib/thor/command.rb`

## Constants

### FILE_REGEXP = /^#{Regexp.escape(File.dirname(__FILE__))}/

## Instance attributes

### #ancestor_name

Returns the value of attribute ancestor_name

Returns: `Object` — the current value of ancestor_name

### #description

Returns the value of attribute description

Returns: `Object` — the current value of description

### #long_description

Returns the value of attribute long_description

Returns: `Object` — the current value of long_description

### #name

Returns the value of attribute name

Returns: `Object` — the current value of name

### #options

Returns the value of attribute options

Returns: `Object` — the current value of options

### #options_relation

Returns the value of attribute options_relation

Returns: `Object` — the current value of options_relation

### #usage

Returns the value of attribute usage

Returns: `Object` — the current value of usage

### #wrap_long_description

Returns the value of attribute wrap_long_description

Returns: `Object` — the current value of wrap_long_description

## Instance methods

### #formatted_usage(klass, namespace = true, subcommand = false)

Returns the formatted usage by injecting given required arguments
and required options into the given usage.

### #hidden?

Returns: `Boolean`

### #initialize(name, description, long_description, wrap_long_description, usage, options = nil, options_relation = nil)

### #initialize_copy(other)

### #method_at_least_one_option_names

### #method_exclusive_option_names

### #run(instance, args = [])

By default, a command invokes a method in the thor class. You can change this
implementation to create custom commands.
