# module Bundler
Defined in: `lib/bundler.rb`

module Bundler::URI

## Constants

### FREEBSD = RbConfig::CONFIG["host_os"].to_s.include?("bsd")

### NULL = File::NULL

### ORIGINAL_ENV = environment_preserver.restore

### SUDO_MUTEX = Thread::Mutex.new

### VERSION = "4.0.20".freeze

### WINDOWS = RbConfig::CONFIG["host_os"] =~ /(msdos|mswin|djgpp|mingw)/

## Class methods

### .app_cache(custom_path = nil)

### .app_config_path

### .auto_install

Automatically install dependencies if `settings[:auto_install]` exists.
This is set through config cmd `bundle config set --global auto_install 1`.

Note that this method `nil`s out the global Definition object, so it
should be called first, before you instantiate anything like an
`Installer` that'll keep a reference to the old one instead.

### .auto_switch

### .bin_path

Returns absolute location of where binstubs are installed to.

### .bundle_path

Returns absolute path of where gems are installed on the filesystem.

### .bundler_major_version

### .clean_env

### .clean_exec(*args)

### .clean_system(*args)

### .clear_gemspec_cache

### .configure

### .configure_custom_gemfile(custom_gemfile = nil)

### .configure_gem_home_and_path(path = bundle_path)

### .configured_bundle_path

### .create_bundle_path

### .current_ruby

Returns current version of Ruby

Returns: `CurrentRuby` — Current version of Ruby

### .default_bundle_dir

### .default_gemfile

### .default_lockfile

### .definition(unlock = nil, lockfile = default_lockfile)

Returns an instance of Bundler::Definition for given Gemfile and lockfile

Parameters:
- `unlock` (`Hash, Boolean, nil`) — Gems that have been requested
  to be updated or true if all gems should be updated
- `lockfile` (`Pathname`) — Path to Gemfile.lock

Returns: `Bundler::Definition`

### .environment

### .feature_flag

### .find_executable(path)

### .frozen_bundle?

Returns: `Boolean`

### .gem_version

### .generic_local_platform

### .git_present?

Returns: `Boolean`

### .home

### .install_path

### .load

### .load_gemspec(file, validate = false)

### .load_gemspec_uncached(file, validate = false)

### .local_platform

### .locked_gems

### .mkdir_p(path)

### .original_env

Returns: `Hash` — Environment present before Bundler was activated

### .original_exec(*args)

Run a `Kernel.exec` to a subcommand with the environment present before Bundler was activated

### .original_system(*args)

Run subcommand with the environment present before Bundler was activated

### .preferred_gemfile_name

### .read_file(file)

### .require(*groups)

Setups Bundler environment (see Bundler.setup) if it is not already set,
and loads all gems from groups specified. Unlike ::setup, can be called
multiple times with different groups (if they were allowed by setup).

Assuming Gemfile

```
gem 'first_gem', '= 1.0'
group :test do
  gem 'second_gem', '= 1.0'
end
```

The code will work as follows:

```
Bundler.setup # allow all groups
Bundler.require(:default) # requires only first_gem
# ...later
Bundler.require(:test)   # requires second_gem
```

### .require_thor_actions

### .reset!

### .reset_paths!

### .reset_rubygems!

### .reset_settings_and_root!

### .rm_rf(path)

### .root

### .ruby_scope

### .rubygems

### .safe_load_marshal(data)

### .self_manager

### .settings

### .setup(*groups)

Turns on the Bundler runtime. After `Bundler.setup` call, all `load` or
`require` of the gems would be allowed only if they are part of
the Gemfile or Ruby's standard library. If the versions specified
in Gemfile, only those versions would be loaded.

Assuming Gemfile

```
gem 'first_gem', '= 1.0'
group :test do
  gem 'second_gem', '= 1.0'
end
```

The code using Bundler.setup works as follows:

```
require 'third_gem' # allowed, required from global gems
require 'first_gem' # allowed, loads the last installed version
Bundler.setup
require 'fourth_gem' # fails with LoadError
require 'second_gem' # loads exactly version 1.0
```

`Bundler.setup` can be called only once, all subsequent calls are no-op.

If *groups* list is provided, only gems from specified groups would
be allowed (gems specified outside groups belong to special `:default` group).

To require all gems from Gemfile (or only some groups), see Bundler.require.

### .simulated_version

### .specs_path

### .system_bindir

### .tmp(name = Process.pid.to_s)

### .ui

### .ui=(ui)

### .unbundle_env!

Remove all bundler-related variables from ENV

### .unbundled_env

Returns: `Hash` — Environment with all bundler-related variables removed

### .unbundled_exec(*args)

Run a `Kernel.exec` to a subcommand in an environment with all bundler related variables removed

### .unbundled_system(*args)

Run subcommand in an environment with all bundler related variables removed

### .URI(uri)

Returns a Bundler::URI object derived from the given `uri`,
which may be a Bundler::URI string or an existing Bundler::URI object:

```
require 'bundler/vendor/uri/lib/uri'
# Returns a new Bundler::URI.
uri = Bundler::URI('http://github.com/ruby/ruby')
# => #<Bundler::URI::HTTP http://github.com/ruby/ruby>
# Returns the given Bundler::URI.
Bundler::URI(uri)
# => #<Bundler::URI::HTTP http://github.com/ruby/ruby>
```

You must require 'bundler/vendor/uri/lib/uri' to use this method.

### .use_system_gems?

Returns: `Boolean`

### .user_bundle_path(dir = "home")

### .user_cache

### .user_home

### .verbose_version

### .which(executable)

### .with_clean_env

### .with_friendly_errors

### .with_original_env

Run block with environment present before Bundler was activated

### .with_unbundled_env

Run block with all bundler-related variables removed
