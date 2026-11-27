# class Bundler::Fetcher::CompactIndex < Bundler::Fetcher::Base
Defined in: `lib/bundler/fetcher/compact_index.rb`

## Class methods

### .compact_index_request(method_name)

## Instance methods

### #api_fetcher?

Returns: `Boolean`

### #available?

Returns: `Boolean`

### #release_resolution_memory!

The client holds the parsed checksums of all info files in the
index. Dropping it is always safe because it is rebuilt from the
local cache on demand.

### #specs(gem_names)

### #specs_for_names(gem_names)
