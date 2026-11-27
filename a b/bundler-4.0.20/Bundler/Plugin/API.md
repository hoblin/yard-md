# class Bundler::Plugin::API
Defined in: `lib/bundler/plugin/api.rb`

## Class methods

### .command(command, cls = self)

The plugins should declare that they handle a command through this helper.

Parameters:
- `command` (`String`) — being handled by them
- `(optional)` (`Class`) — class that handles the command. If not
  provided, the `self` class will be used.

### .hook(event, &block)

### .source(source, cls = self)

The plugins should declare that they provide a installation source
through this helper.

Parameters:
- `the` (`String`) — source type they provide
- `(optional)` (`Class`) — class that handles the source. If not
  provided, the `self` class will be used.

## Instance methods

### #cache_dir

The cache dir to be used by the plugins for storage

Returns: `Pathname` — path of the cache dir

### #method_missing(name, *args, &blk)

### #respond_to_missing?(name, include_private = false)

Returns: `Boolean`

### #tmp(*names)

A tmp dir to be used by plugins
Accepts names that get concatenated as suffix

Returns: `Pathname` — object for the new directory created
