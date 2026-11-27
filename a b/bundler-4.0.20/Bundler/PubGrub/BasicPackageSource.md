# class Bundler::PubGrub::BasicPackageSource
Defined in: `lib/bundler/vendor/pub_grub/lib/pub_grub/basic_package_source.rb`

Types:

Where possible, Bundler::PubGrub will accept user-defined types, so long as they quack.

## "Package":

This class will be used to represent the various packages being solved for.
.to_s will be called when displaying errors and debugging info, it should
probably return the package's name.
It must also have a reasonable definition of #== and #hash

Example classes: String ("rails")


## "Version":

This class will be used to represent a single version number.

Versions don't need to store their associated package, however they will
only be compared against other versions of the same package.

It must be Comparible (and implement <=> reasonably)

Example classes: Gem::Version, Integer


## "Dependency"

This class represents the requirement one package has on another. It is
returned by dependencies_for(package, version) and will be passed to
parse_dependency to convert it to a format Bundler::PubGrub understands.

It must also have a reasonable definition of #==

Example classes: String ("~> 1.0"), Gem::Requirement

## Instance methods

### #all_versions_for(package)

Override me!

This is called per package to find all possible versions of a package.

It is called at most once per-package

Returns: Array of versions for a package, in preferred order of selection

Raises: `NotImplementedError`

### #dependencies_for(package, version)

Override me!

Returns: Hash in the form of { package => requirement, ... }

Raises: `NotImplementedError`

### #incompatibilities_for(package, version)

### #initialize

### #no_versions_incompatibility_for(_package, unsatisfied_term)

### #parse_dependency(package, dependency)

Override me!

Convert a (user-defined) dependency into a format Bundler::PubGrub understands.

Package is passed to this method but for many implementations is not
needed.

Returns: either a Bundler::PubGrub::VersionRange, Bundler::PubGrub::VersionUnion, or a
```
Bundler::PubGrub::VersionConstraint
```

Raises: `NotImplementedError`

### #root_dependencies

Override me!

If not overridden, this will call dependencies_for with the root package.

Returns: Hash in the form of { package => requirement, ... } (see dependencies_for)

### #versions_for(package, range = VersionRange.any)
