# module Bundler::FetchMetadata
Defined in: `lib/bundler/match_remote_metadata.rb`

## Instance methods

### #matches_current_ruby?

A fallback is included because the original version of the specification
API didn't include that field, so some marshalled specs in the index have it
set to `nil`.

Returns: `Boolean`

### #matches_current_rubygems?

Returns: `Boolean`
