# class Bundler::StubSpecification < Bundler::RemoteSpecification
Defined in: `lib/bundler/stub_specification.rb`

## Instance attributes

### #checksum (read-only)

Returns the value of attribute checksum.

### #ignored

Returns the value of attribute ignored.

### #stub

Returns the value of attribute stub.

## Class methods

### .from_stub(stub)

## Instance methods

### #activated=(activated)

### #activated?

Returns: `Boolean`

### #base_dir=(path)

### #default_gem?

Returns: `Boolean`

### #extensions

### #full_gem_path

### #full_gem_path=(path)

### #full_require_paths

### #gem_build_complete_path

### #ignored?

Returns: `Boolean`

### #insecurely_materialized?

Returns: `Boolean`

### #inspect

### #load_paths

### #loaded_from

### #manually_installed?

Returns: `Boolean`

### #matches_for_glob(glob)

### #missing_extensions?

This is defined directly to avoid having to loading the full spec

Returns: `Boolean`

### #raw_require_paths

### #require_paths

### #source=(source)

### #to_yaml
