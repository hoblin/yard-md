# class Bundler::EndpointSpecification < Gem::Specification
Includes: `Bundler::MatchRemoteMetadata`
Defined in: `lib/bundler/endpoint_specification.rb`

used for Creating Specifications from the Gemcutter Endpoint

## Instance attributes

### #checksum (read-only)

Returns the value of attribute checksum.

### #created_at (read-only)

Returns the value of attribute created_at.

### #dependencies

Also known as: `runtime_dependencies`

### #locked_platform

Returns the value of attribute locked_platform.

### #name (read-only)

Returns the value of attribute name.

### #platform (read-only)

Returns the value of attribute platform.

### #remote

Returns the value of attribute remote.

### #version (read-only)

Returns the value of attribute version.

## Instance methods

### #__swap__(spec)

### #_local_specification

### #bindir

needed for bundle clean

### #executables

needed for binstubs

### #extensions

needed for "with native extensions" during install

### #fetch_platform

### #initialize(name, version, platform, spec_fetcher, dependencies, metadata = nil)

### #insecurely_materialized?

Returns: `Boolean`

### #inspect

### #load_paths

needed for inline

### #metadata

needed for `bundle fund`

### #post_install_message

needed for post_install_messages during install

### #raw_require_paths

`require_paths` is overridden above, but `full_require_paths` (and so
`load_paths`) is computed from `raw_require_paths`, which would otherwise
report the default `lib` for every gem

### #require_paths

needed for standalone, load required_paths from local gemspec
after the gem is installed
