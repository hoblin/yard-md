# class Bundler::Resolver::Base
Defined in: `lib/bundler/resolver/base.rb`

## Instance attributes

### #locked_specs (read-only)

Returns the value of attribute locked_specs.

### #packages (read-only)

Returns the value of attribute packages.

### #requirements (read-only)

Returns the value of attribute requirements.

### #source_requirements (read-only)

Returns the value of attribute source_requirements.

## Instance methods

### #[](name)

### #base_requirements

### #delete(specs)

### #explicitly_unlocked?(name)

Gems the user named on a `bundle update GEM` / `bundle lock --update GEM`
command line. These are the only ones meant to move off their locked
version, so cooldown keeps applying to them while every other locked gem
stays exempt.

Returns: `Boolean`

### #get_package(name)

### #include_prereleases(names)

### #include_remote_specs(names)

### #initialize(source_requirements, dependencies, base, platforms, options)

### #unlock_names(names)
