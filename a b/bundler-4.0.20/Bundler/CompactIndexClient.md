# class Bundler::CompactIndexClient
Defined in: `lib/bundler/compact_index_client.rb`

The CompactIndexClient is responsible for fetching and parsing the compact index.

The compact index is a set of caching optimized files that are used to fetch gem information.
The files are:
- names: a list of all gem names
- versions: a list of all gem versions
- info/[gem]: a list of all versions of a gem

The client is instantiated with:
- `directory`: the root directory where the cache files are stored.
- `fetcher`: (optional) an object that responds to #call(uri_path, headers) and returns an http response.
If the `fetcher` is not provided, the client will only read cached files from disk.

The client is organized into:
- `Updater`: updates the cached files on disk using the fetcher.
- `Cache`: calls the updater, caches files, read and return them from disk
- `Parser`: parses the compact index file data
- `CacheFile`: a concurrency safe file reader/writer that verifies checksums

The client is intended to optimize memory usage and performance.
It is called 100s or 1000s of times, parsing files with hundreds of thousands of lines.
It may be called concurrently without global interpreter lock in some Rubies.
As a result, some methods may look more complex than necessary to save memory or time.

## Constants

### DEBUG_MUTEX = Thread::Mutex.new

### INFO_DEPS = 3

### INFO_NAME = 0

info returns an Array of INFO Arrays. Each INFO Array has the following indices:

### INFO_PLATFORM = 2

### INFO_REQS = 4

### INFO_VERSION = 1

### SUPPORTED_DIGESTS = { "sha-256" => :SHA256 }.freeze

## Class methods

### .debug

## Instance methods

### #available?

Returns: `Boolean`

### #dependencies(names)

### #info(name)

### #initialize(directory, fetcher = nil)

### #latest_version(name)

### #names

### #reset!

### #versions
