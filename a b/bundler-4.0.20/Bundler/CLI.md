# class Bundler::CLI < Bundler::Thor
Includes: `Bundler::Thor::Actions`
Defined in: `lib/bundler/cli.rb`

## Constants

### AUTO_INSTALL_CMDS = %w[show binstubs outdated exec open console licenses clean].freeze

### COMMAND_ALIASES

```ruby
COMMAND_ALIASES = {
  "check" => "c",
  "install" => "i",
  "plugin" => "",
  "list" => "ls",
  "exec" => ["e", "ex", "exe"],
  "cache" => ["package", "pack"],
  "version" => ["-v", "--version"],
}.freeze
```

### EXTENSIONS = ["c", "rust", "go"].freeze

### PARSEABLE_COMMANDS = %w[check config help exec platform show version].freeze

## Class methods

### .aliases_for(command_name)

### .all_aliases

### .check_invalid_ext_option(arguments)

### .default_command(meth = nil)

### .dispatch

### .handle_no_command_error(command, has_namespace = $thor_runner)

### .invalid_ext_value?(arguments)

Returns: `Boolean`

### .reformatted_help_args(args)

Reformat the arguments passed to bundle that include a --help flag
into the corresponding `bundle help #{command}` call

### .source_root

### .start

## Instance methods

### #add(*gems)

### #binstubs(*gems)

### #cache

### #check

### #clean

### #cli_help

### #console(group = nil)

### #env

### #exec(*args)

### #fund

### #gem(name)

Raises: `InvalidOption`

### #help(cli = nil)

### #info(gem_name)

### #init

### #initialize(*args)

### #inject

### #install

### #install_or_cli_help

### #issue

### #licenses

### #list

### #lock

### #open(name)

### #outdated(*gems)

### #platform

### #pristine(*gems)

### #remove(*gems)

### #show(gem_name = nil)

### #update(*gems)

### #version

### #viz
