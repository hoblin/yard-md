# class Bundler::Checksum::Store
Defined in: `lib/bundler/checksum.rb`

## Instance methods

### #empty?(spec)

Returns: `Boolean`

### #initialize

### #inspect

### #merge!(other)

### #missing?(spec)

Returns: `Boolean`

### #register(spec, checksum)

### #replace(spec, checksum)

Replace when the new checksum is from the same source.
The primary purpose is registering checksums from gems where there are
duplicates of the same gem (according to full_name) in the index.

In particular, this is when 2 gems have two similar platforms, e.g.
"darwin20" and "darwin-20", both of which resolve to darwin-20.
In the Index, the later gem replaces the former, so we do that here.

However, if the new checksum is from a different source, we register like normal.
This ensures a mismatch error where there are multiple top level sources
that contain the same gem with different checksums.

### #to_lock(spec)
