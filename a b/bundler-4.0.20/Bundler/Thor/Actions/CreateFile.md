# class Bundler::Thor::Actions::CreateFile < Bundler::Thor::Actions::EmptyDirectory
Defined in: `lib/bundler/vendor/thor/lib/thor/actions/create_file.rb`

CreateFile is a subset of Template, which instead of rendering a file with
ERB, it gets the content from the user.

## Instance attributes

### #data (read-only)

## Instance methods

### #identical?

Checks if the content of the file at the destination is identical to the rendered result.

###### Returns
**Boolean** — true if it is identical, false otherwise.

Returns: `Boolean`

### #initialize(base, destination, data, config = {})

### #invoke!

### #render

Holds the content to be added to the file.
