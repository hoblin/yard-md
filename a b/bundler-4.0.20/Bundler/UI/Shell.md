# class Bundler::UI::Shell
Defined in: `lib/bundler/ui/shell.rb`

## Constants

### LEVELS = %w[silent error warn confirm info debug].freeze

### OUTPUT_STREAMS = [:stdout, :stderr].freeze

## Instance attributes

### #output_stream

Returns the value of attribute output_stream.

### #shell (write-only)

Sets the attribute shell

Parameters:
- `value` — the value to set the attribute shell to.

## Instance methods

### #add_color(string, *color)

### #ask(msg)

### #confirm(msg = nil, newline = nil)

### #confirm?

Returns: `Boolean`

### #debug(msg = nil, newline = nil)

### #debug?

Returns: `Boolean`

### #error(msg = nil, newline = nil, color = :red)

### #error?

Returns: `Boolean`

### #info(msg = nil, newline = nil)

### #info?

Returns: `Boolean`

### #initialize(options = {})

### #level(name = nil)

### #level=(level)

Raises: `ArgumentError`

### #no?(msg)

Returns: `Boolean`

### #progress(&blk)

### #quiet?

Returns: `Boolean`

### #silence(&blk)

### #trace(e, newline = nil, force = false)

### #unprinted_warnings

### #warn(msg = nil, newline = nil, color = :yellow)

### #warn?

Returns: `Boolean`

### #yes?(msg)

Returns: `Boolean`
