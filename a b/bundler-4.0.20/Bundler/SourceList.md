# class Bundler::SourceList
Defined in: `lib/bundler/source_list.rb`

## Instance attributes

### #git_sources (read-only)

Returns the value of attribute git_sources.

### #global_path_source (read-only)

Returns the value of attribute global_path_source.

### #metadata_source (read-only)

Returns the value of attribute metadata_source.

### #path_sources (read-only)

Returns the value of attribute path_sources.

### #plugin_sources (read-only)

Returns the value of attribute plugin_sources.

## Instance methods

### #add_git_source(options = {})

### #add_global_rubygems_remote(uri, cooldown: nil)

### #add_path_source(options = {})

### #add_plugin_source(source, options = {})

### #add_rubygems_source(options = {})

### #aggregate_global_source?

Returns: `Boolean`

### #all_sources

### #cached!

### #clear_cache

### #default_source

### #get(source)

### #global_rubygems_source

### #implicit_global_source?

Returns: `Boolean`

### #initialize

### #local!

### #local_mode?

Returns: `Boolean`

### #local_only!

### #lock_other_sources

### #lock_rubygems_sources

### #lock_sources

### #non_default_explicit_sources

### #non_global_rubygems_sources

### #prefer_local!

### #release_resolution_memory!

### #remote!

### #replace_sources!(replacement_sources)

Returns true if there are changes

### #rubygems_sources
