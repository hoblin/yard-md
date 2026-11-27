# class Bundler::EnvironmentPreserver
Defined in: `lib/bundler/environment_preserver.rb`

## Constants

### BUNDLER_KEYS

```ruby
BUNDLER_KEYS = %w[
  BUNDLE_BIN_PATH
  BUNDLE_GEMFILE
  BUNDLE_LOCKFILE
  BUNDLER_VERSION
  BUNDLER_SETUP
  GEM_HOME
  GEM_PATH
  MANPATH
  PATH
  RB_USER_INSTALL
  RUBYLIB
  RUBYOPT
].map(&:freeze).freeze
```

### BUNDLER_PREFIX = "BUNDLER_ORIG_"

### INTENTIONALLY_NIL = "BUNDLER_ENVIRONMENT_PRESERVER_INTENTIONALLY_NIL"

## Class methods

### .from_env

## Instance methods

### #backup

Returns: `Hash`

### #initialize(env, keys)

Parameters:
- `env` (`Hash`)
- `keys` (`Array<String>`)

### #replace_with_backup

Replaces `ENV` with the bundler environment variables backed up

### #restore

Returns: `Hash`
