# class Bundler::Plugin::Installer
Defined in: `lib/bundler/plugin/installer.rb`

## Instance methods

### #install(names, options)

### #install_definition(definition)

Installs the plugin from Definition object created by limited parsing of
Gemfile searching for plugins to be installed

Parameters:
- `definition` (`Definition`) — object

Returns: `Hash` — map of names to their specs they are installed with
