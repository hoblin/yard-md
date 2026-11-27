# class Bundler::SpecSet
Includes: `Gem::TSort`, `Enumerable`
Defined in: `lib/bundler/spec_set.rb`

## Instance methods

### #-(other)

### #<<(spec)

### #[](key)

### #[]=(key, value)

### #add_extra_platforms!(platforms)

### #add_originally_invalid_platforms!(platforms, originally_invalid_platforms)

### #delete(specs)

### #delete_by_name(name)

### #each(&b)

### #empty?

Returns: `Boolean`

### #find_by_name_and_platform(name, platform)

### #for(dependencies, platforms = [nil], legacy_platforms = [nil], skips: [])

### #incomplete_for_platform?(deps, platform)

Returns: `Boolean`

### #incomplete_specs

### #incomplete_specs_for_platform(deps, platform)

### #initialize(specs)

### #insecurely_materialized_specs

### #length

### #materialize(deps)

### #materialized_for_all_platforms

Materialize for all the specs in the spec set, regardless of what platform they're for

Returns: `Array<Gem::Specification>`

### #missing_specs

### #missing_specs_for(deps)

### #names

### #normalize_platforms!(deps, platforms)

### #partially_missing_specs

### #remove_invalid_platforms!(deps, platforms, skips: [])

### #size

### #sort!

### #specs_with_additional_variants_from(other)

### #to_a

### #to_hash

### #to_s

### #valid?(s)

Returns: `Boolean`

### #validate_deps(s)

### #version_for(name)

### #what_required(spec)
