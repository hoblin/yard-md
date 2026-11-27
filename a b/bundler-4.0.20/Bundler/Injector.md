# class Bundler::Injector
Defined in: `lib/bundler/injector.rb`

## Constants

### INJECTED_GEMS = "injected gems"

## Class methods

### .inject(new_deps, options = {})

### .remove(gems, options = {})

## Instance methods

### #initialize(deps, options = {})

### #inject(gemfile_path, lockfile_path)

Parameters:
- `gemfile_path` (`Pathname`) — The Gemfile in which to inject the new dependency.
- `lockfile_path` (`Pathname`) — The lockfile in which to inject the new dependency.

Returns: `Array`

### #remove(gemfile_path, lockfile_path)

Parameters:
- `gemfile_path` (`Pathname`) — The Gemfile from which to remove dependencies.
- `lockfile_path` (`Pathname`) — The lockfile from which to remove dependencies.

Returns: `Array`
