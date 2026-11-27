# class Bundler::Thor::Options < Bundler::Thor::Arguments
Defined in: `lib/bundler/vendor/thor/lib/thor/parser/options.rb`

## Constants

### EQ_RE = /^(--\w+(?:-\w+)*|-[a-z])=(.*)$/i

### LONG_RE = /^(--\w+(?:-\w+)*)$/

### OPTS_END = "--".freeze

### SHORT_NUM = /^(-[a-z])#{NUMERIC}$/i

### SHORT_RE = /^(-[a-z])$/i

### SHORT_SQ_RE = /^-([a-z]{2,})$/i

Allow either -x -v or -xv style for single char args

## Class methods

### .to_switches(options)

Receives a hash and makes it switches.

## Instance methods

### #check_at_least_one!

### #check_exclusive!

### #check_unknown!

Raises: `UnknownArgumentError`

### #initialize(hash_options = {}, defaults = {}, stop_on_unknown = false, disable_required_check = false, relations = {})

Takes a hash of Bundler::Thor::Option and a hash with defaults.

If `stop_on_unknown` is true, #parse will stop as soon as it encounters
an unknown option or a regular argument.

### #parse(args)

rubocop:disable Metrics/MethodLength

### #peek

### #remaining

### #shift

### #unshift(arg, is_value: false)
