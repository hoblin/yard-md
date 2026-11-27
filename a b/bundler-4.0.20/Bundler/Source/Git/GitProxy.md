# class Bundler::Source::Git::GitProxy
Defined in: `lib/bundler/source/git/git_proxy.rb`

The GitProxy is responsible to interact with git repositories.
All actions required by the Git source is encapsulated in this
object.

## Instance attributes

### #branch

Returns the value of attribute branch.

### #explicit_ref

Returns the value of attribute explicit_ref.

### #path

Returns the value of attribute path.

### #ref

Returns the value of attribute ref.

### #revision

### #tag

Returns the value of attribute tag.

### #uri

Returns the value of attribute uri.

## Class methods

### .full_version

### .reset

### .version

## Instance methods

### #checkout

### #contains?(commit)

Returns: `Boolean`

### #copy_to(destination, submodules = false)

### #current_branch

### #full_version

### #initialize(path, uri, options = {}, revision = nil, git = nil)

### #installed_to?(destination)

Returns: `Boolean`

### #version
