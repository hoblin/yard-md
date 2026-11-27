# class Bundler::Thor::Shell::Basic
Defined in: `lib/bundler/vendor/thor/lib/thor/shell/basic.rb`

## Instance attributes

### #base

Returns the value of attribute base.

### #padding

Returns the value of attribute padding.

## Instance methods

### #ask(statement, *args)

Asks something to the user and receives a response.

If a default value is specified it will be presented to the user
and allows them to select that value with an empty response. This
option is ignored when limited answers are supplied.

If asked to limit the correct responses, you can pass in an
array of acceptable answers.  If one of those is not supplied,
they will be shown a message stating that one of those answers
must be given and re-asked the question.

If asking for sensitive information, the :echo option can be set
to false to mask user input from $stdin.

If the required input is a path, then set the path option to
true. This will enable tab completion for file paths relative
to the current working directory on systems that support
Readline.

###### Example
```
ask("What is your name?")

ask("What is the planet furthest from the sun?", :default => "Neptune")

ask("What is your favorite Neopolitan flavor?", :limited_to => ["strawberry", "chocolate", "vanilla"])

ask("What is your password?", :echo => false)

ask("Where should the file be saved?", :path => true)
```

### #error(statement)

Called if something goes wrong during the execution. This is used by Bundler::Thor
internally and should not be used inside your scripts. If something went
wrong, you can always raise an exception. If you raise a Bundler::Thor::Error, it
will be rescued and wrapped in the method below.

### #file_collision(destination)

Deals with file collision and returns true if the file should be
overwritten and false otherwise. If a block is given, it uses the block
response as the content for the diff.

###### Parameters
**destination<String>** — the destination file to solve conflicts
**block<Proc>** — an optional block that returns the value to be used in diff and merge

### #indent(count = 1)

Sets the output padding while executing a block and resets it.

### #initialize

Initialize base, mute and padding to nil.

### #mute

Mute everything that's inside given block

### #mute?

Check if base is muted

Returns: `Boolean`

### #no?(statement, color = nil)

Asks the user a question and returns true if the user replies "n" or
"no".

Returns: `Boolean`

### #print_in_columns(array)

Prints values in columns

###### Parameters
Array[String, String, ...]

### #print_table(array, options = {})

Prints a table.

###### Parameters
Array[Array[String, String, ...]]

###### Options
**indent<Integer>** — Indent the first column by indent value.
**colwidth<Integer>** — Force the first column to colwidth spaces wide.
**borders<Boolean>** — Adds ascii borders.

### #print_wrapped(message, options = {})

Prints a long string, word-wrapping the text to the current width of the
terminal display. Ideal for printing heredocs.

###### Parameters
String

###### Options
**indent<Integer>** — Indent each line of the printed paragraph by indent value.

### #say(message = "", color = nil, force_new_line = (message.to_s !~ /( |\t)\Z/))

Say (print) something to the user. If the sentence ends with a whitespace
or tab character, a new line is not appended (print + flush). Otherwise
are passed straight to puts (behavior got from Highline).

###### Example
```
say("I know you knew that.")
```

### #say_error(message = "", color = nil, force_new_line = (message.to_s !~ /( |\t)\Z/))

Say (print) an error to the user. If the sentence ends with a whitespace
or tab character, a new line is not appended (print + flush). Otherwise
are passed straight to puts (behavior got from Highline).

###### Example
```
say_error("error: something went wrong")
```

### #say_status(status, message, log_status = true)

Say a status with the given color and appends the message. Since this
method is used frequently by actions, it allows nil or false to be given
in log_status, avoiding the message from being shown. If a Symbol is
given in log_status, it's used as the color.

### #set_color(string)

Apply color to the given string with optional bold. Disabled in the
Bundler::Thor::Shell::Basic class.

### #yes?(statement, color = nil)

Asks the user a question and returns true if the user replies "y" or
"yes".

Returns: `Boolean`
