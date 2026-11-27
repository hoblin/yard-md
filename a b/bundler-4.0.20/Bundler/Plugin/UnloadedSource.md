# class Bundler::Plugin::UnloadedSource
Includes: `Bundler::Plugin::API::Source`
Defined in: `lib/bundler/plugin/unloaded_source.rb`

Stands in for a source handled by a plugin that is not loaded yet, so
that the lockfile can still be parsed during the plugin install pass,
and by external tools reading a lockfile without the plugin installed.

## Instance methods

### #==(other)

Unlike real plugin sources, where the handling class encodes the
source type, all unloaded sources share this class, so the type must
be compared explicitly.

Also known as: `eql?`

### #hash
