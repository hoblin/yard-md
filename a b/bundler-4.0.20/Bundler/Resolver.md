# class Bundler::Resolver
Defined in: `lib/bundler/resolver.rb`

This class implements the interface needed by PubGrub for resolution. It is
equivalent to the `PubGrub::BasicPackageSource` class provided by PubGrub by
default and used by the most simple PubGrub consumers.

## Instance attributes

### #cooldown_skipped (read-only)

Returns the value of attribute cooldown_skipped.

## Instance methods

### #all_versions_for(package)

### #bundler_pinned_to_current_version?

Returns: `Boolean`

### #debug?

Returns: `Boolean`

### #default_bundler_source

### #find_names_to_relax(incompatibility)

### #incompatibilities_for(package, version)

### #initialize(base, gem_version_promoter, most_specific_locked_platform = nil)

### #name_for_explicit_dependency_source

### #no_versions_incompatibility_for(package, unsatisfied_term)

### #parse_dependency(package, dependency)

### #raise_incomplete!(incomplete_specs)

### #setup_solver

### #solve_versions(root:, logger:)

### #sort_versions_by_preferred(package, versions)

### #source_for(name)

### #start

### #versions_for(package, range = VersionRange.any)
