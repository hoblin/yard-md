# module Rake::FileUtilsExt
Includes: `FileUtils`
Extended by: `Rake::FileUtilsExt`
Defined in: `lib/rake/file_utils_ext.rb`

FileUtilsExt provides a custom version of the FileUtils methods
that respond to the `verbose` and `nowrite`
commands.

## Constants

### DEFAULT = Object.new

## Class attributes

### .nowrite_flag

Returns the value of attribute nowrite_flag.

### .verbose_flag

Returns the value of attribute verbose_flag.

## Instance methods

### #nowrite(value = nil)

Get/set the nowrite flag controlling output from the FileUtils
utilities.  If verbose is true, then the utility method is
echoed to standard output.

Examples:
```
nowrite              # return the current value of the
                     # nowrite flag
nowrite(v)           # set the nowrite flag to _v_.
nowrite(v) { code }  # Execute code with the nowrite flag set
                     # temporarily to _v_. Return to the
                     # original value when code is done.
```

### #rake_check_options(options, *optdecl)

Check that the options do not contain options not listed in
`optdecl`.  An ArgumentError exception is thrown if non-declared
options are found.

Raises: `ArgumentError`

### #rake_output_message(message)

Send the message to the default rake output (which is $stderr).

### #verbose(value = nil)

Get/set the verbose flag controlling output from the FileUtils
utilities.  If verbose is true, then the utility method is
echoed to standard output.

Examples:
```
verbose              # return the current value of the
                     # verbose flag
verbose(v)           # set the verbose flag to _v_.
verbose(v) { code }  # Execute code with the verbose flag set
                     # temporarily to _v_.  Return to the
                     # original value when code is done.
```

### #when_writing(msg = nil)

Use this function to prevent potentially destructive ruby code
from running when the :nowrite flag is set.

Example:

```
when_writing("Building Project") do
  project.build
end
```

The following code will build the project under normal
conditions. If the nowrite(true) flag is set, then the example
will print:

```
DRYRUN: Building Project
```

instead of actually building the project.
