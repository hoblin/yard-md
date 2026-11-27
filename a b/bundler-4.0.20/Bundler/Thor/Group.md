# class Bundler::Thor::Group
Includes: `Bundler::Thor::Base`
Defined in: `lib/bundler/vendor/thor/lib/thor/group.rb`

Bundler::Thor has a special class called Bundler::Thor::Group. The main difference to Bundler::Thor class
is that it invokes all commands at once. It also include some methods that allows
invocations to be done at the class method, which are not available to Bundler::Thor
commands.

## Class methods

### .class_options_help(shell, groups = {})

Overwrite class options help to allow invoked generators options to be
shown recursively when invoking a generator.

### .command_exists?(command_name)

Checks if a specified command exists.

###### Parameters
**command_name<String>** — The name of the command to check for existence.

###### Returns
**Boolean** — `true` if the command exists, `false` otherwise.

Returns: `Boolean`

### .desc(description = nil)

The description for this Bundler::Thor::Group. If none is provided, but a source root
exists, tries to find the USAGE one folder above it, otherwise searches
in the superclass.

###### Parameters
**description<String>** — The description for this Bundler::Thor::Group.

### .get_options_from_invocations(group_options, base_options)

Get invocations array and merge options from invocations. Those
options are added to group_options hash. Options that already exists
in base_options are not added twice.

### .handle_argument_error(command, error, _args, arity)

Raises: `error`

### .help(shell)

Prints help information.

###### Options
**short** — When true, shows only usage.

### .invocation_blocks

Stores invocation blocks used on invoke_from_option.

### .invocations

Stores invocations for this class merging with superclass values.

### .invoke(*names, &block)

Invoke the given namespace or class given. It adds an instance
method that will invoke the klass and command. You can give a block to
configure how it will be invoked.

The namespace/class given will have its options showed on the help
usage. Check invoke_from_option for more information.

### .invoke_from_option(*names, &block)

Invoke a thor class based on the value supplied by the user to the
given option named "name". A class option must be created before this
method is invoked for each name given.

###### Examples

```
class GemGenerator < Bundler::Thor::Group
  class_option :test_framework, :type => :string
  invoke_from_option :test_framework
end
```

###### Boolean options

In some cases, you want to invoke a thor class if some option is true or
false. This is automatically handled by invoke_from_option. Then the
option name is used to invoke the generator.

###### Preparing for invocation

In some cases you want to customize how a specified hook is going to be
invoked. You can do that by overwriting the class method
prepare_for_invocation. The class method must necessarily return a klass
and an optional command.

###### Custom invocations

You can also supply a block to customize how the option is going to be
invoked. The block receives two parameters, an instance of the current
class and the klass to be invoked.

### .printable_commands

Returns commands ready to be printed.

Also known as: `printable_tasks`

### .remove_invocation(*names)

Remove a previously added invocation.

###### Examples

```
remove_invocation :test_framework
```
