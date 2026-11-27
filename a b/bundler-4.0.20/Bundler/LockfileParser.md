# class Bundler::LockfileParser
Defined in: `lib/bundler/lockfile_parser.rb`

## Constants

### BUNDLED = "BUNDLED WITH"

### CHECKSUMS = "CHECKSUMS"

### DEPENDENCIES = "DEPENDENCIES"

### ENVIRONMENT_VERSION_SECTIONS = [BUNDLED, RUBY].freeze

### GEM = "GEM"

### GIT = "GIT"

### KNOWN_SECTIONS = SECTIONS_BY_VERSION_INTRODUCED.values.flatten!.freeze

### OPTIONS = /^  ([a-z]+): (.*)$/i

### PATH = "PATH"

### PLATFORMS = "PLATFORMS"

### PLUGIN = "PLUGIN SOURCE"

### RUBY = "RUBY VERSION"

### SECTIONS_BY_VERSION_INTRODUCED

```ruby
SECTIONS_BY_VERSION_INTRODUCED = {
  Gem::Version.create("1.0") => [DEPENDENCIES, PLATFORMS, GIT, GEM, PATH].freeze,
  Gem::Version.create("1.10") => [BUNDLED].freeze,
  Gem::Version.create("1.12") => [RUBY].freeze,
  Gem::Version.create("1.13") => [PLUGIN].freeze,
  Gem::Version.create("2.5.0") => [CHECKSUMS].freeze,
}.freeze
```

### SOURCE = [GIT, GEM, PATH, PLUGIN].freeze

### SPECS = "  specs:"

## Instance attributes

### #bundler_version (read-only)

Returns the value of attribute bundler_version.

### #dependencies (read-only)

Returns the value of attribute dependencies.

### #metadata_source (read-only)

Returns the value of attribute metadata_source.

### #most_specific_locked_platform (read-only)

Returns the value of attribute most_specific_locked_platform.

### #platforms (read-only)

Returns the value of attribute platforms.

### #ruby_version (read-only)

Returns the value of attribute ruby_version.

### #sources (read-only)

Returns the value of attribute sources.

### #specs (read-only)

Returns the value of attribute specs.

## Class methods

### .bundled_with

### .sections_in_lockfile(lockfile_contents)

### .sections_to_ignore(base_version = nil)

### .unknown_sections_in_lockfile(lockfile_contents)

## Instance methods

### #initialize(lockfile, strict: false)

### #may_include_redundant_platform_specific_gems?

Returns: `Boolean`

### #valid?

Returns: `Boolean`
