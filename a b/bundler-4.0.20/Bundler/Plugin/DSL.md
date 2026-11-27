# class Bundler::Plugin::DSL < Bundler::Dsl
Defined in: `lib/bundler/plugin/dsl.rb`

Dsl to parse the Gemfile looking for plugins to install

## Instance attributes

### #inferred_plugins (read-only)

This lists the plugins that was added automatically and not specified by
the user.

When we encounter :type attribute with a source block, we add a plugin
by name bundler-source-<type> to list of plugins to be installed.

These plugins are optional and are not installed when there is conflict
with any other plugin.

## Instance methods

### #initialize

### #method_missing(name, *args)

Raises: `PluginGemfileError`

### #plugin(name, *args)

### #source(source, *args, &blk)
