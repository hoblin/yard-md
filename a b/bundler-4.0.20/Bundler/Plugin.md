# module Bundler::Plugin
Defined in: `lib/bundler/plugin/api.rb`

SourceList object to be used while parsing the Gemfile, setting the
approptiate options to be used with Source classes for plugin installation

## Constants

### PLUGIN_FILE_NAME = "plugins.rb"

## Class methods

### .add_command(command, cls)

To be called via the API to register to handle a command

### .add_hook(event, &block)

To be called via the API to register a hooks and corresponding block that
will be called to handle the hook

### .add_source(source, cls)

To be called via the API to register to handle a source plugin

### .cache

The cache directory for plugin stuffs

### .command?(command)

Checks if any plugin handles the command

Returns: `Boolean`

### .exec_command(command, args)

To be called from Cli class to pass the command and argument to
appropriate plugin class

Raises: `UndefinedCommandError`

### .from_lock(locked_opts)

Parameters:
- `The` (`Hash`) — options that are present in the lockfile

Returns: `API::Source` — the instance of the class that handles the source
  type passed in locked_opts

### .gemfile_install(gemfile = nil, &inline)

Evaluates the Gemfile with a limited DSL and installs the plugins
specified by plugin method

Parameters:
- `gemfile` (`Pathname`) — path
- `block` (`Proc`) — that can be evaluated for (inline) Gemfile

### .global_root

The global directory root for all plugin related data

### .hook(event, *args, &arg_blk)

Runs all the hooks that are registered for the passed event

It passes the passed arguments and block to the block registered with
the api.

Parameters:
- `event` (`String`)

### .index

The index object used to store the details about the plugin

### .install(names, options)

Installs a new plugin by the given name

Parameters:
- `names` (`Array<String>`) — the name of plugin to be installed
- `options` (`Hash`) — various parameters as described in description.
  Refer to cli/plugin for available options

### .installed?(plugin)

currently only intended for specs

Returns: `String, nil` — installed path

### .list

List installed plugins and commands

### .load_plugin(name)

Executes the plugins.rb file

Parameters:
- `name` (`String`) — of the plugin

### .loaded?(plugin)

Returns: `true, false` — whether the plugin is loaded

### .local_root

### .register_plugin(name, spec, optional_plugin = false)

Runs the plugins.rb file in an isolated namespace, records the plugin
actions it registers for and then passes the data to index to be stored.

Parameters:
- `name` (`String`) — the name of the plugin
- `spec` (`Specification`) — of installed plugin
- `optional_plugin,` (`Boolean`) — removed if there is conflict with any
  other plugin (used for default source plugins)

Raises: `MalformattedPlugin` — if plugins.rb raises any error

### .reset!

### .root

The directory root for all plugin related data

If run in an app, points to local root, in app_config_path
Otherwise, points to global root, in Bundler.user_bundle_path("plugin")

### .save_plugin(name, spec, optional_plugin = false)

Validates and registers a plugin.

Parameters:
- `name` (`String`) — the name of the plugin
- `spec` (`Specification`) — of installed plugin
- `optional_plugin,` (`Boolean`) — removed if there is conflict with any
  other plugin (used for default source plugins)

Raises: `PluginInstallError` — if validation or registration raises any error

### .save_plugins(plugins, specs, optional_plugins = [])

Post installation processing and registering with index

Parameters:
- `plugins` (`Array<String>`) — list to be installed
- `specs` (`Hash`) — of plugins mapped to installation path (currently they
  contain all the installed specs, including plugins)
- `names` (`Array<String>`) — of inferred source plugins that can be ignored

### .source(name)

Returns: `Class` — that handles the source. The class includes API::Source

Raises: `UnknownSourceError`

### .source?(name)

Checks if any plugin declares the source

Returns: `Boolean`

### .uninstall(names, options)

Uninstalls plugins by the given names

Parameters:
- `names` (`Array<String>`) — the names of plugins to be uninstalled

### .validate_plugin!(plugin_path)

Checks if the gem is good to be a plugin

At present it only checks whether it contains plugins.rb file

Parameters:
- `plugin_path` (`Pathname`) — the path plugin is installed at

Raises: `MalformattedPlugin` — if plugins.rb file is not found
