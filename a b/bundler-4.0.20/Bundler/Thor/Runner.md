# class Bundler::Thor::Runner < Bundler::Thor
Defined in: `lib/bundler/vendor/thor/lib/thor/runner.rb`

## Class methods

### .banner(command, all = false, subcommand = false)

### .exit_on_failure?

Returns: `Boolean`

## Instance methods

### #help(meth = nil)

Override Bundler::Thor#help so it can give information about any class and any method.

### #install(name)

rubocop:disable Metrics/MethodLength

### #installed

### #list(search = "")

### #method_missing(meth, *args)

If a command is not found on Bundler::Thor::Runner, method missing is invoked and
Bundler::Thor::Runner is then responsible for finding the command in all classes.

### #uninstall(name)

Raises: `Error`

### #update(name)

Raises: `Error`

### #version
