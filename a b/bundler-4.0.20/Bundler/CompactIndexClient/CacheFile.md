# class Bundler::CompactIndexClient::CacheFile
Defined in: `lib/bundler/compact_index_client/cache_file.rb`

write cache files in a way that is robust to concurrent modifications
if digests are given, the checksums will be verified

## Instance attributes

### #original_path (read-only)

Returns the value of attribute original_path.

### #path (read-only)

Returns the value of attribute path.

## Class methods

### .copy(path, &block)

Initialize with a copy of the original file, then yield the instance.

### .write(path, data, digests = nil)

Write data to a temp file, then replace the original file with it verifying the digests if given.

## Instance methods

### #append(data)

Returns false without appending when no digests since appending is too error prone to do without digests.

### #close

Remove the temp file without replacing the original file.
The file is permanently closed.

### #commit

Replace the original file with the temp file without verifying digests.
The file is permanently closed.

Raises: `ClosedError`

### #commit!

### #digests=(expected_digests)

set the digests that will be verified at the end

### #digests?

Returns: `Boolean`

### #initialize(original_path, &block)

### #initialize_digests(keys = nil)

initialize the digests using CompactIndexClient::SUPPORTED_DIGESTS, or a subset based on keys.

### #open(write_mode = "wb", perm = @perm, &block)

Open the temp file for writing, reusing original permissions, yielding the IO object.

Raises: `ClosedError`

### #reset_digests

reset the digests so they don't contain any previously read data

### #size

### #verify

Verify the digests, returning true on match, false on mismatch.

### #write(data)
