# class Bundler::Settings
Defined in: `lib/bundler/mirror.rb`

## Constants

### ARRAY_KEYS

```ruby
ARRAY_KEYS = %w[
  only
  with
  without
].freeze
```

### BOOL_KEYS

```ruby
BOOL_KEYS = %w[
  auto_install
  cache_all
  cache_all_platforms
  clean
  deployment
  disable_checksum_validation
  disable_exec_load
  disable_local_branch_check
  disable_local_revision_check
  disable_shared_gems
  disable_version_check
  force_ruby_platform
  frozen
  gem.changelog
  gem.coc
  gem.mit
  gem.bundle
  git.allow_insecure
  global_gem_cache
  ignore_messages
  init_gems_rb
  inline
  lockfile_checksums
  no_install
  no_prune
  path.system
  plugins
  prefer_patch
  silence_deprecations
  silence_root_warning
  update_requires_all_flag
  verbose
].freeze
```

### DEFAULT_CONFIG

```ruby
DEFAULT_CONFIG = {
  "BUNDLE_SILENCE_DEPRECATIONS" => false,
  "BUNDLE_DISABLE_VERSION_CHECK" => true,
  "BUNDLE_PREFER_PATCH" => false,
  "BUNDLE_REDIRECT" => 5,
  "BUNDLE_RETRY" => 3,
  "BUNDLE_TIMEOUT" => 10,
  "BUNDLE_VERSION" => "lockfile",
  "BUNDLE_LOCKFILE_CHECKSUMS" => true,
  "BUNDLE_CACHE_ALL" => true,
  "BUNDLE_PLUGINS" => true,
  "BUNDLE_GLOBAL_GEM_CACHE" => false,
  "BUNDLE_UPDATE_REQUIRES_ALL_FLAG" => false,
}.freeze
```

### NUMBER_KEYS

```ruby
NUMBER_KEYS = %w[
  cooldown
  jobs
  redirect
  retry
  ssl_verify_mode
  timeout
].freeze
```

### STRING_KEYS

```ruby
STRING_KEYS = %w[
  bin
  cache_path
  console
  default_cli_command
  gem.ci
  gem.github_username
  gem.linter
  gem.rubocop
  gem.test
  gemfile
  lockfile
  path
  shebang
  simulate_version
  system_bindir
  trust-policy
  version
].freeze
```

## Class methods

### .key_for(key)

### .key_to_s(key)

### .normalize_uri(uri)

TODO: duplicates Rubygems#normalize_uri
TODO: is this the correct place to validate mirror URIs?

## Instance methods

### #[](name)

### #all

### #app_cache_path

### #credentials_for(uri)

### #gem_mirrors

### #ignore_config?

Returns: `Boolean`

### #initialize(root = nil)

### #installation_parallelization

### #key_for(key)

### #local_overrides

### #locations(key)

### #mirror_for(uri)

### #path

for legacy reasons, in Bundler 2, we do not respect :disable_shared_gems

### #pretty_values_for(exposed_key)

### #processor_count

### #set_command_option(key, value)

### #set_command_option_if_given(key, value)

### #set_global(key, value)

### #set_local(key, value)

### #temporary(update)

### #validate!
