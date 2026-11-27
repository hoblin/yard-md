# class Bundler::CLI::Doctor::Diagnose
Defined in: `lib/bundler/cli/doctor/diagnose.rb`

## Constants

### DARWIN_REGEX = /\s+(.+) \(compatibility /

### LDD_REGEX = /\t\S+ => (\S+) \(\S+\)/

## Instance attributes

### #options (read-only)

Returns the value of attribute options.

## Instance methods

### #bundles_for_gem(spec)

### #check!

### #diagnose_ssl

### #dylibs(path)

### #dylibs_darwin(path)

### #dylibs_ldd(path)

### #initialize(options)

### #ldd_available?

Returns: `Boolean`

### #lookup_with_fiddle(path)

### #otool_available?

Returns: `Boolean`

### #run
