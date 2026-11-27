# class Bundler::Thor::Actions::CreateLink < Bundler::Thor::Actions::CreateFile
Defined in: `lib/bundler/vendor/thor/lib/thor/actions/create_link.rb`

CreateLink is a subset of CreateFile, which instead of taking a block of
data, just takes a source string from the user.

## Instance attributes

### #data (read-only)

## Instance methods

### #exists?

Returns: `Boolean`

### #identical?

Checks if the content of the file at the destination is identical to the rendered result.

###### Returns
**Boolean** — true if it is identical, false otherwise.

Returns: `Boolean`

### #invoke!
