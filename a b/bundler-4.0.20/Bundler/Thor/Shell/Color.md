# class Bundler::Thor::Shell::Color < Bundler::Thor::Shell::Basic
Defined in: `lib/bundler/vendor/thor/lib/thor/shell/color.rb`

Inherit from Bundler::Thor::Shell::Basic and add set_color behavior. Check
Bundler::Thor::Shell::Basic to see all available methods.

## Constants

### BLACK = "\e[30m"

Set the terminal's foreground ANSI color to black.

### BLUE = "\e[34m"

Set the terminal's foreground ANSI color to blue.

### BOLD = "\e[1m"

The start of an ANSI bold sequence.

### CLEAR = "\e[0m"

Embed in a String to clear all previous ANSI sequences.

### CYAN = "\e[36m"

Set the terminal's foreground ANSI color to cyan.

### GREEN = "\e[32m"

Set the terminal's foreground ANSI color to green.

### MAGENTA = "\e[35m"

Set the terminal's foreground ANSI color to magenta.

### ON_BLACK = "\e[40m"

Set the terminal's background ANSI color to black.

### ON_BLUE = "\e[44m"

Set the terminal's background ANSI color to blue.

### ON_CYAN = "\e[46m"

Set the terminal's background ANSI color to cyan.

### ON_GREEN = "\e[42m"

Set the terminal's background ANSI color to green.

### ON_MAGENTA = "\e[45m"

Set the terminal's background ANSI color to magenta.

### ON_RED = "\e[41m"

Set the terminal's background ANSI color to red.

### ON_WHITE = "\e[47m"

Set the terminal's background ANSI color to white.

### ON_YELLOW = "\e[43m"

Set the terminal's background ANSI color to yellow.

### RED = "\e[31m"

Set the terminal's foreground ANSI color to red.

### WHITE = "\e[37m"

Set the terminal's foreground ANSI color to white.

### YELLOW = "\e[33m"

Set the terminal's foreground ANSI color to yellow.

## Instance methods

### #set_color(string, *colors)

Set color by using a string or one of the defined constants. If a third
option is set to true, it also adds bold to the string. This is based
on Highline implementation and it automatically appends CLEAR to the end
of the returned String.

Pass foreground, background and bold options to this method as
symbols.

Example:

```
set_color "Hi!", :red, :on_white, :bold
```

The available colors are:

```
:bold
:black
:red
:green
:yellow
:blue
:magenta
:cyan
:white
:on_black
:on_red
:on_green
:on_yellow
:on_blue
:on_magenta
:on_cyan
:on_white
```
