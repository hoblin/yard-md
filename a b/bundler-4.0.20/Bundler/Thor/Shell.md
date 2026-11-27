# module Bundler::Thor::Shell
Defined in: `lib/bundler/vendor/thor/lib/thor/shell.rb`

## Constants

### SHELL_DELEGATED_METHODS = [:ask, :error, :set_color, :yes?, :no?, :say, :say_error, :say_status, :print_in_columns, :print_table, :print_wrapped, :file_collision, :terminal_width]

## Instance attributes

### #shell

Holds the shell for the given Bundler::Thor instance. If no shell is given,
it gets a default shell from Bundler::Thor::Base.shell.

## Instance methods

### #initialize(args = [], options = {}, config = {})

Add shell to initialize config values.

###### Configuration
**shell<Object>** — An instance of the shell to be used.

###### Examples

```
class MyScript < Bundler::Thor
  argument :first, :type => :numeric
end

MyScript.new [1.0], { :foo => :bar }, :shell => Bundler::Thor::Shell::Basic.new
```

### #with_padding

Yields the given block with padding.
