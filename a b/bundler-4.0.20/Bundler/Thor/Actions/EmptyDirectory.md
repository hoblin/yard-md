# class Bundler::Thor::Actions::EmptyDirectory
Defined in: `lib/bundler/vendor/thor/lib/thor/actions/empty_directory.rb`

Class which holds create directory logic. This is the base class for
other actions like create_file and directory.

This implementation is based in Templater actions, created by Jonas Nicklas
and Michael S. Klishin under MIT LICENSE.

## Instance attributes

### #base (read-only)

### #config (read-only)

### #destination (read-only)

### #given_destination (read-only)

### #relative_destination (read-only)

## Instance methods

### #exists?

Checks if the destination file already exists.

###### Returns
**Boolean** — true if the file exists, false otherwise.

Returns: `Boolean`

### #initialize(base, destination, config = {})

Initializes given the source and destination.

###### Parameters
base<Bundler::Thor::Base>:: A Bundler::Thor::Base instance
**source<String>** — Relative path to the source of this file
**destination<String>** — Relative path to the destination of this file
**config<Hash>** — give :verbose => false to not log the status.

### #invoke!

### #revoke!
