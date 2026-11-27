# class Bundler::Plugin::Index
Defined in: `lib/bundler/plugin/index.rb`

## Instance attributes

### #commands (read-only)

Returns the value of attribute commands.

## Instance methods

### #command_plugin(command)

Fetch the name of plugin handling the command

### #global_index_file

Path where the global index file is stored

### #hook_plugins(event)

Returns the list of plugin names handling the passed event

### #index_file

Path of default index file

### #initialize

### #installed?(name)

Returns: `Boolean`

### #installed_in_plugin_root?(name)

This plugin is installed inside the .bundle/plugin directory,
and thus is managed solely by Bundler

Returns: `Boolean`

### #installed_plugins

### #load_paths(name)

### #local_index_file

Path where the local index file is stored

### #plugin_commands(plugin)

### #plugin_path(name)

### #register_plugin(name, path, load_paths, commands, sources, hooks)

This function is to be called when a new plugin is installed. This
function shall add the functions of the plugin to existing maps and also
the name to source location.

Parameters:
- `name` (`String`) — of the plugin to be registered
- `path` (`String`) — where the plugin is installed
- `load_paths` (`Array<String>`) — for the plugin
- `commands` (`Array<String>`) — that are handled by the plugin
- `sources` (`Array<String>`) — that are handled by the plugin

### #source?(source)

Returns: `Boolean`

### #source_plugin(name)

### #unregister_plugin(name)

### #up_to_date?(spec)

Returns: `Boolean`
