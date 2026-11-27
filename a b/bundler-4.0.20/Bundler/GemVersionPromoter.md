# class Bundler::GemVersionPromoter
Defined in: `lib/bundler/gem_version_promoter.rb`

This class contains all of the logic for determining the next version of a
Gem to update to based on the requested level (patch, minor, major).
Primarily designed to work with Resolver which will provide it the list of
available dependency versions as found in its index, before returning it to
to the resolution engine to select the best version.

## Instance attributes

### #level

Returns the value of attribute level.

### #pre

Returns the value of attribute pre.

### #strict

By default, strict is false, meaning every available version of a gem
is returned from sort_versions. The order gives preference to the
requested level (:patch, :minor, :major) but in complicated requirement
cases some gems will by necessity be promoted past the requested level,
or even reverted to older versions.

If strict is set to true, the results from sort_versions will be
truncated, eliminating any version outside the current level scope.
This can lead to unexpected outcomes or even VersionConflict exceptions
that report a version of a gem not existing for versions that indeed do
existing in the referenced source.

## Instance methods

### #filter_versions(package, specs)

Given a Resolver::Package and an Array of Specifications of available
versions for a gem, this method will truncate the Array if strict
is true. That means filtering out downgrades from the version currently
locked, and filtering out upgrades that go past the selected level (major,
minor, or patch).

Parameters:
- `package` (`Resolver::Package`) — The package being resolved.
- `specs` (`Specification`) — An array of Specifications for the package.

Returns: `Specification` — A new instance of the Specification Array
  truncated.

### #initialize

Creates a GemVersionPromoter instance.

### #major?

Returns: `bool` — Convenience method for testing value of level variable.

### #minor?

Returns: `bool` — Convenience method for testing value of level variable.

### #pre?

Returns: `bool` — Convenience method for testing value of pre variable.

### #sort_versions(package, specs)

Given a Resolver::Package and an Array of Specifications of available
versions for a gem, this method will return the Array of Specifications
sorted in an order to give preference to the current level (:major, :minor
or :patch) when resolution is deciding what versions best resolve all
dependencies in the bundle.

Parameters:
- `package` (`Resolver::Package`) — The package being resolved.
- `specs` (`Specification`) — An array of Specifications for the package.

Returns: `Specification` — A new instance of the Specification Array sorted.
