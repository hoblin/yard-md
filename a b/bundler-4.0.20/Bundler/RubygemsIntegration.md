# class Bundler::RubygemsIntegration
Defined in: `lib/bundler/rubygems_integration.rb`

## Constants

### EXT_LOCK = Monitor.new

## Instance methods

### #add_default_gems_to(specs)

Add default gems not already present in specs, and return them as a hash.

### #all_specs

### #bin_path(gem, bin, ver)

### #build(spec, skip_validation = false)

### #build_args

### #build_args=(args)

### #build_gem(gem_dir, spec)

### #clear_paths

### #default_specs

### #default_stubs

### #download_gem(spec, uri, cache_dir, fetcher)

### #ext_lock

### #fetch_all_remote_specs(remote, gem_remote_fetcher)

### #fetch_specs(remote, name, fetcher)

### #find_bundler(version)

### #find_name(name)

### #gem_bindir

### #gem_cache

### #gem_dir

### #gem_path

### #inflate(obj)

### #initialize

### #installed_specs

### #loaded_gem_paths

### #loaded_specs(name)

### #mark_loaded(spec)

### #marshal_spec_dir

### #method_visibility(klass, method)

### #path(obj)

### #path_separator

### #plain_specs

### #plain_specs=(specs)

### #post_reset_hooks

### #provides?(req_str)

Returns: `Boolean`

### #read_binary(path)

### #redefine_method(klass, method, unbound_method = nil, &block)

### #replace_bin_path(specs_by_name)

Used to give better error messages when activating specs outside of the current bundle

### #replace_entrypoints(specs)

Replace or hook into RubyGems to provide a bundlerized view
of the world.

### #replace_gem(specs_by_name)

### #reset

### #reverse_rubygems_kernel_mixin

### #ruby_engine

### #security_policies

### #security_policy_keys

### #set_target_rbconfig(path)

### #spec_cache_dirs

### #spec_from_gem(path)

### #stub_rubygems(specs)

### #stub_set_spec(stub, spec)

### #suffix_pattern

### #ui=(obj)

### #undo_replacements

### #user_home

### #validate(spec)

### #version
