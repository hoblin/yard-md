# class Bundler::Source::Git < Bundler::Source::Path
Defined in: `lib/bundler/source/git.rb`

## Instance attributes

### #branch (read-only)

Returns the value of attribute branch.

### #glob (read-only)

Returns the value of attribute glob.

### #options (read-only)

Returns the value of attribute options.

### #ref (read-only)

Returns the value of attribute ref.

### #submodules (read-only)

Returns the value of attribute submodules.

### #uri (read-only)

Returns the value of attribute uri.

## Class methods

### .from_lock(options)

## Instance methods

### #allow_git_ops?

Returns: `Boolean`

### #app_cache_dirname

### #cache(spec, custom_path = nil)

### #cache_path

This is the path which is going to contain a cache
of the git repository. When using the same git repository
across different projects, this cache will be shared.
When using local git repos, this is set to the local repo.

### #cached!

### #current_branch

### #eql?(other)

Returns: `Boolean`

Also known as: `==`

### #extension_dir_name

### #hash

### #identifier

### #include?(other)

Returns: `Boolean`

### #initialize(options)

### #install(spec, options = {})

### #install_path

This is the path which is going to contain a specific
checkout of the git repository. When using local git
repos, this is set to the local repo.

Also known as: `path`

### #load_spec_files

### #local?

Returns: `Boolean`

### #local_override!(path)

### #migrate_cache(custom_path = nil, local: false)

### #name

### #remote!

### #revision

### #specs

### #to_gemfile

### #to_lock

### #to_s

### #unlock!

### #uri_with_specifiers(specifiers)
