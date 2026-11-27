# class Bundler::UI::Silent
Defined in: `lib/bundler/ui/silent.rb`

## Instance attributes

### #shell (write-only)

Sets the attribute shell

Parameters:
- `value` — the value to set the attribute shell to.

## Instance methods

### #add_color(string, color)

### #ask(message)

### #confirm(message = nil, newline = nil)

### #confirm?

Returns: `Boolean`

### #debug(message = nil, newline = nil)

### #debug?

Returns: `Boolean`

### #error(message = nil, newline = nil)

### #error?

Returns: `Boolean`

### #info(message = nil, newline = nil)

### #info?

Returns: `Boolean`

### #initialize

### #level(name = nil)

### #level=(name)

### #no?(msg)

Returns: `Boolean`

### #output_stream

### #output_stream=(_symbol)

### #progress

### #quiet?

Returns: `Boolean`

### #silence

### #trace(message, newline = nil, force = false)

### #unprinted_warnings

### #warn(message = nil, newline = nil)

### #warn?

Returns: `Boolean`

### #yes?(msg)

Returns: `Boolean`
