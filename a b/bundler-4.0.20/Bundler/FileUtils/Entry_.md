# class Bundler::FileUtils::Entry_
Includes: `Bundler::FileUtils::StreamUtils_`
Defined in: `lib/bundler/vendor/fileutils/lib/fileutils.rb`

## Constants

### S_IF_DOOR = 0xD000

## Instance methods

### #blockdev?

Returns: `Boolean`

### #chardev?

Returns: `Boolean`

### #chmod(mode)

### #chown(uid, gid)

### #copy(dest)

### #copy_file(dest)

### #copy_metadata(path)

### #dereference?

Returns: `Boolean`

### #directory?

Returns: `Boolean`

### #door?

Returns: `Boolean`

### #entries

### #exist?

Returns: `Boolean`

### #file?

Returns: `Boolean`

### #initialize(a, b = nil, deref = false)

### #inspect

### #link(dest)

### #lstat

### #lstat!

### #path

### #pipe?

Returns: `Boolean`

### #platform_support

### #postorder_traverse {|_self| ... }

Yields: `_self`

Yield Parameters:
- `_self` (`Bundler::FileUtils::Entry_`) — the object that the method was called on

### #prefix

### #preorder_traverse

Also known as: `traverse`

### #rel

### #remove

### #remove_dir1

### #remove_file

### #socket?

Returns: `Boolean`

### #stat

### #stat!

### #symlink?

Returns: `Boolean`

### #wrap_traverse(pre, post)
