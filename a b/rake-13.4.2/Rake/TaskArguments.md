# class Rake::TaskArguments
Includes: `Enumerable`
Defined in: `lib/rake/task_arguments.rb`

TaskArguments manage the arguments passed to a task.

## Instance attributes

### #names (read-only)

Argument names

## Instance methods

### #[](index)

Find an argument value by name or index.

### #deconstruct_keys(keys)

### #each(&block)

Enumerates the arguments and their values

### #extras

Retrieve the list of values not associated with named arguments

### #fetch(*args, &block)

### #has_key?(key)

Returns true if `key` is one of the arguments

Returns: `Boolean`

Also known as: `key?`

### #initialize(names, values, parent = nil)

Create a TaskArgument object with a list of argument `names` and a set
of associated `values`.  `parent` is the parent argument object.

### #inspect

### #method_missing(sym, *args)

Returns the value of the given argument via method_missing

### #new_scope(names)

Create a new argument scope using the prerequisite argument
names.

### #to_a

Retrieve the complete array of sequential values

### #to_hash

Returns a Hash of arguments and their values

### #to_s

### #values_at(*keys)

Extracts the argument values at `keys`

### #with_defaults(defaults)

Specify a hash of default values for task arguments. Use the
defaults only if there is no specific value for the given
argument.
