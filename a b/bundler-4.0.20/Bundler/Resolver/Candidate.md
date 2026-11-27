# class Bundler::Resolver::Candidate
Includes: `Comparable`
Defined in: `lib/bundler/resolver/candidate.rb`

This class is a PubGrub compatible "Version" class that takes Bundler
resolution complexities into account.

Each Resolver::Candidate has a underlying `Gem::Version` plus a set of
platforms. For example, 1.1.0-x86_64-linux is a different resolution candidate
from 1.1.0 (generic). This is because different platform variants of the
same gem version can bring different dependencies, so they need to be
considered separately.

Some candidates may also keep some information explicitly about the
package they refer to. These candidates are referred to as "canonical" and
are used when materializing resolution results back into RubyGems
specifications that can be installed, written to lockfiles, and so on.

## Instance attributes

### #version (read-only)

Returns the value of attribute version.

## Instance methods

### #<=>(other)

### #==(other)

### #dependencies

### #eql?(other)

Returns: `Boolean`

### #hash

### #initialize(version, group: nil, priority: -1))

### #prerelease?

Returns: `Boolean`

### #segments

### #to_s

### #to_specs(package, most_specific_locked_platform)
