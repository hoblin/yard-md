# class Bundler::Thor::Shell::HTML < Bundler::Thor::Shell::Basic
Defined in: `lib/bundler/vendor/thor/lib/thor/shell/html.rb`

Inherit from Bundler::Thor::Shell::Basic and add set_color behavior. Check
Bundler::Thor::Shell::Basic to see all available methods.

## Constants

### BLACK = "color: black"

Set the terminal's foreground HTML color to black.

### BLUE = "color: blue"

Set the terminal's foreground HTML color to blue.

### BOLD = "font-weight: bold"

The start of an HTML bold sequence.

### CYAN = "color: cyan"

Set the terminal's foreground HTML color to cyan.

### GREEN = "color: green"

Set the terminal's foreground HTML color to green.

### MAGENTA = "color: magenta"

Set the terminal's foreground HTML color to magenta.

### ON_BLACK = "background-color: black"

Set the terminal's background HTML color to black.

### ON_BLUE = "background-color: blue"

Set the terminal's background HTML color to blue.

### ON_CYAN = "background-color: cyan"

Set the terminal's background HTML color to cyan.

### ON_GREEN = "background-color: green"

Set the terminal's background HTML color to green.

### ON_MAGENTA = "background-color: magenta"

Set the terminal's background HTML color to magenta.

### ON_RED = "background-color: red"

Set the terminal's background HTML color to red.

### ON_WHITE = "background-color: white"

Set the terminal's background HTML color to white.

### ON_YELLOW = "background-color: yellow"

Set the terminal's background HTML color to yellow.

### RED = "color: red"

Set the terminal's foreground HTML color to red.

### WHITE = "color: white"

Set the terminal's foreground HTML color to white.

### YELLOW = "color: yellow"

Set the terminal's foreground HTML color to yellow.

## Instance methods

### #ask(statement, color = nil)

Ask something to the user and receives a response.

###### Example
```
ask("What is your name?")
```

TODO: Implement #ask for Bundler::Thor::Shell::HTML

Raises: `NotImplementedError`

### #set_color(string, *colors)

Set color by using a string or one of the defined constants. If a third
option is set to true, it also adds bold to the string. This is based
on Highline implementation and it automatically appends CLEAR to the end
of the returned String.
