# class Bundler::Materialization
Defined in: `lib/bundler/materialization.rb`

This class materializes a set of resolved specifications (`LazySpecification`)
for a given gem into the most appropriate real specifications
(`StubSepecification`, `EndpointSpecification`, etc), given a dependency and a
target platform.

## Instance methods

### #complete?

Returns: `Boolean`

### #completely_missing_specs

### #dependencies

### #incomplete_specs

### #initialize(dep, platform, candidates:)

### #materialized_spec

### #partially_missing_specs

### #specs
