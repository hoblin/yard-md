# class Bundler::Dsl
Includes: `Bundler::RubyDsl`
Defined in: `lib/bundler/dsl.rb`

## Constants

### GITHUB_PULL_REQUEST_URL = %r{\Ahttps://github\.com/([A-Za-z0-9_\-\.]+/[A-Za-z0-9_\-\.]+)/pull/(\d+)\z}

### GITLAB_MERGE_REQUEST_URL = %r{\Ahttps://gitlab\.com/([A-Za-z0-9_\-\./]+)/-/merge_requests/(\d+)\z}

### VALID_KEYS

```ruby
VALID_KEYS = %w[group groups git path glob name branch ref tag require submodules
platform platforms source install_if force_ruby_platform].freeze
```

### VALID_PLATFORMS = Bundler::CurrentRuby::PLATFORM_MAP.keys.freeze

## Instance attributes

### #dependencies

Returns the value of attribute dependencies.

### #gemfile (read-only)

Returns the value of attribute gemfile.

### #gemspecs (read-only)

Returns the value of attribute gemspecs.

## Class methods

### .evaluate(gemfile, lockfile, unlock)

## Instance methods

### #check_primary_source_safety

### #env(name)

### #eval_gemfile(gemfile, contents = nil)

### #gem(name, *args)

### #gemspec(opts = nil)

### #git(uri, options = {}, &blk)

### #git_source(name, &block)

### #github(repo, options = {})

Raises: `InvalidArgumentError`

### #group(*args, &blk)

### #initialize

### #install_if(*args)

### #lockfile(file)

### #lockfile_path

For usage in Dsl.evaluate, since lockfile is used as part of the Gemfile.

### #method_missing(name, *args)

Raises: `GemfileError`

### #path(path, options = {}, &blk)

### #platforms(*platforms)

Also known as: `platform`

### #plugin(*args)

### #source(source, *args, &blk)

### #to_definition(lockfile, unlock)
