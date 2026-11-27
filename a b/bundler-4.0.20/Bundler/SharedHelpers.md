# module Bundler::SharedHelpers
Extended by: `Bundler::SharedHelpers`
Defined in: `lib/bundler/shared_helpers.rb`

## Instance methods

### #bundle_bin_path

### #chdir(dir, &blk)

### #checksum_for_file(path, digest)

### #default_bundle_dir

### #default_gemfile

Raises: `GemfileNotFound`

### #default_lockfile

### #digest(name)

### #ensure_same_dependencies(spec, old_deps, new_deps)

Raises: `APIResponseMismatchError`

### #feature_deprecated!(message)

### #feature_removed!(message)

Raises: `RemovedError`

### #filesystem_access(path, action = :write) { ... }

Rescues permissions errors raised by file system operations
(ie. Errno:EACCESS, Errno::EAGAIN) and raises more friendly errors instead.

Example:

```ruby
filesystem_access("vendor/cache", :create) do
  FileUtils.mkdir_p("vendor/cache")
end
```

Parameters:
- `path` (`String`) — the path that the action will be attempted to
- `action` (`Symbol, #to_s`) — the type of operation that will be
  performed. For example: :write, :read, :exec

Yields: path

Raises:
- `Bundler::PermissionError` — if Errno:EACCES is raised in the
  given block
- `Bundler::TemporaryResourceError` — if Errno:EAGAIN is raised in the
  given block

See Also:
- `{Bundler::PermissionError}`

### #gemspec_path

### #glob_files_in_dir(glob, base_path)

Globs for entries matching `glob` inside of `base_path`, returning
absolute paths. Glob metacharacters in `base_path` are not treated as
part of the pattern, and matched entries are joined literally, so an
entry starting with `~` is not expanded into the home directory.

Bundler runs against whatever RubyGems the host provides, so this cannot
delegate to Gem::Util.glob_files_in_dir, which only gained the literal
join in RubyGems 4.1.

### #in_bundle?

Returns: `Boolean`

### #md5_available?

Returns: `Boolean`

### #pretty_dependency(dep)

### #print_major_deprecations!

### #pwd

### #relative_gemfile_path

### #relative_lockfile_path

### #relative_path_to(destination, from: pwd)

### #root

Raises: `GemfileNotFound`

### #set_bundle_environment

### #set_env(key, value)

Raises: `ArgumentError`

### #with_clean_git_env(&block)

### #write_to_gemfile(gemfile_path, contents)
