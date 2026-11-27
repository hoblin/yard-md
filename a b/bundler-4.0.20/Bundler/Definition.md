# class Bundler::Definition
Defined in: `lib/bundler/definition.rb`

## Class attributes

### .no_lock

Do not create or modify a lockfile (Makes #lock a noop)

## Instance attributes

### #dependencies (read-only)

Returns the value of attribute dependencies.

### #gemfiles (read-only)

Returns the value of attribute gemfiles.

### #locked_checksums (read-only)

Returns the value of attribute locked_checksums.

### #locked_deps (read-only)

Returns the value of attribute locked_deps.

### #locked_gems (read-only)

Returns the value of attribute locked_gems.

### #lockfile

Returns the value of attribute lockfile.

### #platforms (read-only)

Returns the value of attribute platforms.

### #ruby_version (read-only)

Returns the value of attribute ruby_version.

### #sources (read-only)

Returns the value of attribute sources.

## Class methods

### .build(gemfile, lockfile, unlock)

Given a gemfile and lockfile creates a Bundler definition

Parameters:
- `gemfile` (`Pathname`) — Path to Gemfile
- `lockfile` (`Pathname, nil`) — Path to Gemfile.lock
- `unlock` (`Hash, Boolean, nil`) — Gems that have been requested
  to be updated or true if all gems should be updated

Returns: `Bundler::Definition`

Raises: `GemfileNotFound`

## Instance methods

### #add_checksums

### #add_platform(platform)

### #bundler_version_to_lock

### #check!

### #cooldown_skipped

Versions excluded by cooldown during the last resolution, one entry per
gem with the newest skipped version. Empty when no resolution ran.

### #current_dependencies

### #current_locked_dependencies

### #deleted_deps

### #dependencies_for(groups)

### #ensure_equivalent_gemfile_and_lockfile(explicit_flag = false)

Raises: `ProductionError`

### #filter_relevant(dependencies)

### #gem_version_promoter

### #groups

### #initialize(lockfile, dependencies, sources, unlock, ruby_version = nil, optional_groups = [], gemfiles = [])

How does the new system work?

* Load information from Gemfile and Lockfile
* Invalidate stale locked specs
 * All specs from stale source are stale
 * All specs that are reachable only through a stale
   dependency are stale.
* If all fresh dependencies are satisfied by the locked
 specs, then we can try to resolve locally.

Parameters:
- `lockfile` (`Pathname`) — Path to Gemfile.lock
- `dependencies` (`Array(Bundler::Dependency)`) — array of dependencies from Gemfile
- `sources` (`Bundler::SourceList`)
- `unlock` (`Hash, Boolean, nil`) — Gems that have been requested
  to be updated or true if all gems should be updated
- `ruby_version` (`Bundler::RubyVersion, nil`) — Requested Ruby Version
- `optional_groups` (`Array(String)`) — A list of optional groups

### #lock(file_or_preserve_unknown_sections = false, preserve_unknown_sections_or_unused = false)

### #locked_dependencies

### #locked_ruby_version

### #locked_ruby_version_object

### #missing_specs

### #missing_specs?

Returns: `Boolean`

### #new_deps

### #new_specs

### #no_resolve_needed?

Returns: `Boolean`

### #normalize_platforms

### #nothing_changed?

Returns: `Boolean`

### #prefer_local!

### #release_resolution_memory!

Releases memory only needed during resolution, such as remote spec
indexes and resolver state. Only safe to call once resolution is
complete and the result has been materialized, since any further
resolution will need to refetch remote specs.

### #relevant_deps?(dep)

Returns: `Boolean`

### #remotely!

### #remove_platform(platform)

Raises: `InvalidOption`

### #removed_specs

### #requested_dependencies

### #requested_specs

### #resolve

Resolve all the dependencies specified in Gemfile. It ensures that
dependencies that have been already resolved via locked file and are fresh
are reused when resolving dependencies

Returns: `SpecSet` — resolved dependencies

### #resolve_remotely!

### #resolve_with_cache!

### #setup_domain!(options = {})

Setup sources according to the given options and the state of the
definition.

Returns: `Boolean` — Whether fetching remote information will be necessary or not

### #spec_git_paths

### #specs

For given dependency list returns a SpecSet with Gemspec of all the required
dependencies.
 1. The method first resolves the dependencies specified in Gemfile
 2. After that it tries and fetches gemspec of resolved dependencies

Returns: `Bundler::SpecSet`

### #specs_for(groups)

### #to_lock

### #unlocking?

Returns: `Boolean`

### #validate_platforms!

Raises: `ProductionError`

### #validate_ruby!

### #validate_runtime!

### #with_cache!

### #write_lock(file, preserve_unknown_sections)
