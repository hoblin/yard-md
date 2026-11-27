# class Bundler::Source::Rubygems < Source
Defined in: `lib/bundler/source/rubygems.rb`

## Constants

### API_REQUEST_SIZE = 100

Ask for X gems per API request

### REQUIRE_MUTEX = Mutex.new

## Instance attributes

### #remote_cooldowns

Returns the value of attribute remote_cooldowns.

### #remotes

Returns the value of attribute remotes.

## Class methods

### .from_lock(options)

## Instance methods

### #add_remote(source, cooldown: nil)

### #cache(spec, custom_path = nil)

### #cached!

### #cached_built_in_gem(spec, local: false)

### #caches

### #can_lock?(spec)

Returns: `Boolean`

### #clear_cache

### #cooldown_for(uri)

### #dependency_api_available?

Returns: `Boolean`

### #dependency_names_to_double_check

### #double_check_for(unmet_dependency_names)

### #download(spec, options = {})

### #eql?(other)

Returns: `Boolean`

Also known as: `==`

### #fetchers

### #hash

### #identifier

Also known as: `name`, `to_gemfile`

### #include?(o)

Returns: `Boolean`

### #initialize(options = {})

### #install(spec, options = {})

### #local!

### #local_only!

### #local_only?

Returns: `Boolean`

### #multiple_remotes?

Returns: `Boolean`

### #no_remotes?

Returns: `Boolean`

### #options

### #prefer_local!

### #release_resolution_memory!

### #remote!

### #remote_fetchers

### #spec_names

### #specs

### #to_lock

### #to_s

### #unmet_deps
