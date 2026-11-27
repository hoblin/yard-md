# module Bundler::BuildMetadata
Defined in: `lib/bundler/build_metadata.rb`

Represents metadata from when the Bundler gem was built.

## Class methods

### .built_at

A string representing the date the bundler gem was built.

### .git_commit_sha

The SHA for the git commit the bundler gem was built from.

### .timestamp

A timestamp representing the date the bundler gem was built, or the
current time if never built

### .to_h

A hash representation of the build metadata.
