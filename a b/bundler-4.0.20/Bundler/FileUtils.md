# module Bundler::FileUtils
Includes: `Bundler::FileUtils::StreamUtils_`
Extended by: `Bundler::FileUtils::StreamUtils_`
Defined in: `lib/bundler/vendor/fileutils/lib/fileutils.rb`

Namespace for file utility methods for copying, moving, removing, etc.

### What's Here

First, what’s elsewhere. Module Bundler::FileUtils:

- Inherits from [class Object](https://docs.ruby-lang.org/en/master/Object.html).
- Supplements [class File](https://docs.ruby-lang.org/en/master/File.html)
  (but is not included or extended there).

Here, module Bundler::FileUtils provides methods that are useful for:

- Creating.
- Deleting.
- Querying.
- Setting.
- Comparing.
- Copying.
- Moving.
- Options.

#### Creating

- ::mkdir: Creates directories.
- ::mkdir_p, ::makedirs, ::mkpath: Creates directories,
  also creating ancestor directories as needed.
- ::link_entry: Creates a hard link.
- ::ln, ::link: Creates hard links.
- ::ln_s, ::symlink: Creates symbolic links.
- ::ln_sf: Creates symbolic links, overwriting if necessary.
- ::ln_sr: Creates symbolic links relative to targets

#### Deleting

- ::remove_dir: Removes a directory and its descendants.
- ::remove_entry: Removes an entry, including its descendants if it is a directory.
- ::remove_entry_secure: Like ::remove_entry, but removes securely.
- ::remove_file: Removes a file entry.
- ::rm, ::remove: Removes entries.
- ::rm_f, ::safe_unlink: Like ::rm, but removes forcibly.
- ::rm_r: Removes entries and their descendants.
- ::rm_rf, ::rmtree: Like ::rm_r, but removes forcibly.
- ::rmdir: Removes directories.

#### Querying

- ::pwd, ::getwd: Returns the path to the working directory.
- ::uptodate?: Returns whether a given entry is newer than given other entries.

#### Setting

- ::cd, ::chdir: Sets the working directory.
- ::chmod: Sets permissions for an entry.
- ::chmod_R: Sets permissions for an entry and its descendants.
- ::chown: Sets the owner and group for entries.
- ::chown_R: Sets the owner and group for entries and their descendants.
- ::touch: Sets modification and access times for entries,
  creating if necessary.

#### Comparing

- ::compare_file, ::cmp, ::identical?: Returns whether two entries are identical.
- ::compare_stream: Returns whether two streams are identical.

#### Copying

- ::copy_entry: Recursively copies an entry.
- ::copy_file: Copies an entry.
- ::copy_stream: Copies a stream.
- ::cp, ::copy: Copies files.
- ::cp_lr: Recursively creates hard links.
- ::cp_r: Recursively copies files, retaining mode, owner, and group.
- ::install: Recursively copies files, optionally setting mode,
  owner, and group.

#### Moving

- ::mv, ::move: Moves entries.

#### Options

- ::collect_method: Returns the names of methods that accept a given option.
- ::commands: Returns the names of methods that accept options.
- ::have_option?: Returns whether a given method accepts a given option.
- ::options: Returns all option names.
- ::options_of: Returns the names of the options for a given method.

### Path Arguments

Some methods in Bundler::FileUtils accept *path* arguments,
which are interpreted as paths to filesystem entries:

- If the argument is a string, that value is the path.
- If the argument has method `:to_path`, it is converted via that method.
- If the argument has method `:to_str`, it is converted via that method.

### About the Examples

Some examples here involve trees of file entries.
For these, we sometimes display trees using the
[tree command-line utility](https://en.wikipedia.org/wiki/Tree_(command)),
which is a recursive directory-listing utility that produces
a depth-indented listing of files and directories.

We use a helper method to launch the command and control the format:

```
def tree(dirpath = '.')
  command = "tree --noreport --charset=ascii #{dirpath}"
  system(command)
end
```

To illustrate:

```
tree('src0')
# => src0
#    |-- sub0
#    |   |-- src0.txt
#    |   `-- src1.txt
#    `-- sub1
#        |-- src2.txt
#        `-- src3.txt
```

### Avoiding the TOCTTOU Vulnerability

For certain methods that recursively remove entries,
there is a potential vulnerability called the
[Time-of-check to time-of-use](https://en.wikipedia.org/wiki/Time-of-check_to_time-of-use),
or TOCTTOU, vulnerability that can exist when:

- An ancestor directory of the entry at the target path is world writable;
  such directories include `/tmp`.
- The directory tree at the target path includes:

  - A world-writable descendant directory.
  - A symbolic link.

To avoid that vulnerability, you can use this method to remove entries:

- Bundler::FileUtils.remove_entry_secure: removes recursively
  if the target path points to a directory.

Also available are these methods,
each of which calls Bundler::FileUtils.remove_entry_secure:

- Bundler::FileUtils.rm_r with keyword argument `secure: true`.
- Bundler::FileUtils.rm_rf with keyword argument `secure: true`.

Finally, this method for moving entries calls Bundler::FileUtils.remove_entry_secure
if the source and destination are on different file systems
(which means that the "move" is really a copy and remove):

- Bundler::FileUtils.mv with keyword argument `secure: true`.

Method Bundler::FileUtils.remove_entry_secure removes securely
by applying a special pre-process:

- If the target path points to a directory, this method uses methods
  [File#chown](https://docs.ruby-lang.org/en/master/File.html#method-i-chown)
  and [File#chmod](https://docs.ruby-lang.org/en/master/File.html#method-i-chmod)
  in removing directories.
- The owner of the target directory should be either the current process
  or the super user (root).

WARNING: You must ensure that **ALL** parent directories cannot be
moved by other untrusted users.  For example, parent directories
should not be owned by untrusted users, and should not be world
writable except when the sticky bit is set.

For details of this security vulnerability, see Perl cases:

- [CVE-2005-0448](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0448).
- [CVE-2004-0452](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2004-0452).

## Constants

### VERSION = "1.8.0"

The version number.

## Class methods

### .cd(dir, verbose: nil, &block)

Changes the working directory to the given `dir`, which
should be interpretable as a path:

With no block given,
changes the current directory to the directory at `dir`; returns zero:

```
Bundler::FileUtils.pwd # => "/rdoc/fileutils"
Bundler::FileUtils.cd('..')
Bundler::FileUtils.pwd # => "/rdoc"
Bundler::FileUtils.cd('fileutils')
```

With a block given, changes the current directory to the directory
at `dir`, calls the block with argument `dir`,
and restores the original current directory; returns the block's value:

```
Bundler::FileUtils.pwd                                     # => "/rdoc/fileutils"
Bundler::FileUtils.cd('..') { |arg| [arg, Bundler::FileUtils.pwd] } # => ["..", "/rdoc"]
Bundler::FileUtils.pwd                                     # => "/rdoc/fileutils"
```

Keyword arguments:

- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.cd('..')
Bundler::FileUtils.cd('fileutils')
```

  Output:

```
cd ..
cd fileutils
```

Related: Bundler::FileUtils.pwd.

### .chdir

Changes the working directory to the given `dir`, which
should be interpretable as a path:

With no block given,
changes the current directory to the directory at `dir`; returns zero:

```
Bundler::FileUtils.pwd # => "/rdoc/fileutils"
Bundler::FileUtils.cd('..')
Bundler::FileUtils.pwd # => "/rdoc"
Bundler::FileUtils.cd('fileutils')
```

With a block given, changes the current directory to the directory
at `dir`, calls the block with argument `dir`,
and restores the original current directory; returns the block's value:

```
Bundler::FileUtils.pwd                                     # => "/rdoc/fileutils"
Bundler::FileUtils.cd('..') { |arg| [arg, Bundler::FileUtils.pwd] } # => ["..", "/rdoc"]
Bundler::FileUtils.pwd                                     # => "/rdoc/fileutils"
```

Keyword arguments:

- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.cd('..')
Bundler::FileUtils.cd('fileutils')
```

  Output:

```
cd ..
cd fileutils
```

Related: Bundler::FileUtils.pwd.

### .chmod(mode, list, noop: nil, verbose: nil)

Changes permissions on the entries at the paths given in `list`
(a single path or an array of paths)
to the permissions given by `mode`;
returns `list` if it is an array, `[list]` otherwise:

- Modifies each entry that is a regular file using
  [File.chmod](https://docs.ruby-lang.org/en/master/File.html#method-c-chmod).
- Modifies each entry that is a symbolic link using
  [File.lchmod](https://docs.ruby-lang.org/en/master/File.html#method-c-lchmod).

Argument `list` or its elements
should be interpretable as paths.

Argument `mode` may be either an integer or a string:

- Integer `mode`: represents the permission bits to be set:

```
Bundler::FileUtils.chmod(0755, 'src0.txt')
Bundler::FileUtils.chmod(0644, ['src0.txt', 'src0.dat'])
```

- String `mode`: represents the permissions to be set:

  The string is of the form `[targets][[operator][perms[,perms]]`, where:

  - `targets` may be any combination of these letters:

    - `'u'`: permissions apply to the file's owner.
    - `'g'`: permissions apply to users in the file's group.
    - `'o'`: permissions apply to other users not in the file's group.
    - `'a'` (the default): permissions apply to all users.

  - `operator` may be one of these letters:

    - `'+'`: adds permissions.
    - `'-'`: removes permissions.
    - `'='`: sets (replaces) permissions.

  - `perms` (may be repeated, with separating commas)
    may be any combination of these letters:

    - `'r'`: Read.
    - `'w'`: Write.
    - `'x'`: Execute (search, for a directory).
    - `'X'`: Search (for a directories only;
      must be used with `'+'`)
    - `'s'`: Uid or gid.
    - `'t'`: Sticky bit.

  Examples:

    Bundler::FileUtils.chmod('u=wrx,go=rx', 'src1.txt')
    Bundler::FileUtils.chmod('u=wrx,go=rx', '/usr/bin/ruby')

Keyword arguments:

- `noop: true` - does not change permissions; returns `nil`.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.chmod(0755, 'src0.txt', noop: true, verbose: true)
Bundler::FileUtils.chmod(0644, ['src0.txt', 'src0.dat'], noop: true, verbose: true)
Bundler::FileUtils.chmod('u=wrx,go=rx', 'src1.txt', noop: true, verbose: true)
Bundler::FileUtils.chmod('u=wrx,go=rx', '/usr/bin/ruby', noop: true, verbose: true)
```

  Output:

```
chmod 755 src0.txt
chmod 644 src0.txt src0.dat
chmod u=wrx,go=rx src1.txt
chmod u=wrx,go=rx /usr/bin/ruby
```

Related: Bundler::FileUtils.chmod_R.

### .chmod_R(mode, list, noop: nil, verbose: nil, force: nil)

Like Bundler::FileUtils.chmod, but changes permissions recursively.

### .chown(user, group, list, noop: nil, verbose: nil)

Changes the owner and group on the entries at the paths given in `list`
(a single path or an array of paths)
to the given `user` and `group`;
returns `list` if it is an array, `[list]` otherwise:

- Modifies each entry that is a regular file using
  [File.chown](https://docs.ruby-lang.org/en/master/File.html#method-c-chown).
- Modifies each entry that is a symbolic link using
  [File.lchown](https://docs.ruby-lang.org/en/master/File.html#method-c-lchown).

Argument `list` or its elements
should be interpretable as paths.

User and group:

- Argument `user` may be a user name or a user id;
  if `nil` or `-1`, the user is not changed.
- Argument `group` may be a group name or a group id;
  if `nil` or `-1`, the group is not changed.
- The user must be a member of the group.

Examples:

```
# One path.
# User and group as string names.
File.stat('src0.txt').uid # => 1004
File.stat('src0.txt').gid # => 1004
Bundler::FileUtils.chown('user2', 'group1', 'src0.txt')
File.stat('src0.txt').uid # => 1006
File.stat('src0.txt').gid # => 1005

# User and group as uid and gid.
Bundler::FileUtils.chown(1004, 1004, 'src0.txt')
File.stat('src0.txt').uid # => 1004
File.stat('src0.txt').gid # => 1004

# Array of paths.
Bundler::FileUtils.chown(1006, 1005, ['src0.txt', 'src0.dat'])

# Directory (not recursive).
Bundler::FileUtils.chown('user2', 'group1', '.')
```

Keyword arguments:

- `noop: true` - does not change permissions; returns `nil`.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.chown('user2', 'group1', 'src0.txt', noop: true, verbose: true)
Bundler::FileUtils.chown(1004, 1004, 'src0.txt', noop: true, verbose: true)
Bundler::FileUtils.chown(1006, 1005, ['src0.txt', 'src0.dat'], noop: true, verbose: true)
Bundler::FileUtils.chown('user2', 'group1', path, noop: true, verbose: true)
Bundler::FileUtils.chown('user2', 'group1', '.', noop: true, verbose: true)
```

  Output:

```
chown user2:group1 src0.txt
chown 1004:1004 src0.txt
chown 1006:1005 src0.txt src0.dat
chown user2:group1 src0.txt
chown user2:group1 .
```

Related: Bundler::FileUtils.chown_R.

### .chown_R(user, group, list, noop: nil, verbose: nil, force: nil)

Like Bundler::FileUtils.chown, but changes owner and group recursively.

### .cmp

Returns `true` if the contents of files `a` and `b` are identical,
`false` otherwise.

Arguments `a` and `b`
should be interpretable as a path.

Bundler::FileUtils.identical? and Bundler::FileUtils.cmp are aliases for Bundler::FileUtils.compare_file.

Related: Bundler::FileUtils.compare_stream.

### .collect_method(opt)

Returns an array of the string method names of the methods
that accept the given keyword option `opt`;
the argument must be a symbol:

```
Bundler::FileUtils.collect_method(:preserve) # => ["cp", "copy", "cp_r", "install"]
```

### .commands

Returns an array of the string names of Bundler::FileUtils methods
that accept one or more keyword arguments:

```
Bundler::FileUtils.commands.sort.take(3) # => ["cd", "chdir", "chmod"]
```

### .compare_file(a, b)

Returns `true` if the contents of files `a` and `b` are identical,
`false` otherwise.

Arguments `a` and `b`
should be interpretable as a path.

Bundler::FileUtils.identical? and Bundler::FileUtils.cmp are aliases for Bundler::FileUtils.compare_file.

Related: Bundler::FileUtils.compare_stream.

### .compare_stream(a, b)

Returns `true` if the contents of streams `a` and `b` are identical,
`false` otherwise.

Arguments `a` and `b`
should be interpretable as a path.

Related: Bundler::FileUtils.compare_file.

### .copy

Copies files.

Arguments `src` (a single path or an array of paths)
and `dest` (a single path)
should be interpretable as paths.

If `src` is the path to a file and `dest` is not the path to a directory,
copies `src` to `dest`:

```
Bundler::FileUtils.touch('src0.txt')
File.exist?('dest0.txt') # => false
Bundler::FileUtils.cp('src0.txt', 'dest0.txt')
File.file?('dest0.txt')  # => true
```

If `src` is the path to a file and `dest` is the path to a directory,
copies `src` to `dest/src`:

```
Bundler::FileUtils.touch('src1.txt')
Bundler::FileUtils.mkdir('dest1')
Bundler::FileUtils.cp('src1.txt', 'dest1')
File.file?('dest1/src1.txt') # => true
```

If `src` is an array of paths to files and `dest` is the path to a directory,
copies from each `src` to `dest`:

```
src_file_paths = ['src2.txt', 'src2.dat']
Bundler::FileUtils.touch(src_file_paths)
Bundler::FileUtils.mkdir('dest2')
Bundler::FileUtils.cp(src_file_paths, 'dest2')
File.file?('dest2/src2.txt') # => true
File.file?('dest2/src2.dat') # => true
```

Keyword arguments:

- `preserve: true` - preserves file times.
- `noop: true` - does not copy files.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.cp('src0.txt', 'dest0.txt', noop: true, verbose: true)
Bundler::FileUtils.cp('src1.txt', 'dest1', noop: true, verbose: true)
Bundler::FileUtils.cp(src_file_paths, 'dest2', noop: true, verbose: true)
```

  Output:

```
cp src0.txt dest0.txt
cp src1.txt dest1
cp src2.txt src2.dat dest2
```

Raises an exception if `src` is a directory.

Related: methods for copying.

### .copy_entry(src, dest, preserve = false, dereference_root = false, remove_destination = false)

Recursively copies files from `src` to `dest`.

Arguments `src` and `dest`
should be interpretable as paths.

If `src` is the path to a file, copies `src` to `dest`:

```
Bundler::FileUtils.touch('src0.txt')
File.exist?('dest0.txt') # => false
Bundler::FileUtils.copy_entry('src0.txt', 'dest0.txt')
File.file?('dest0.txt')  # => true
```

If `src` is a directory, recursively copies `src` to `dest`:

```
tree('src1')
# => src1
#    |-- dir0
#    |   |-- src0.txt
#    |   `-- src1.txt
#    `-- dir1
#        |-- src2.txt
#        `-- src3.txt
Bundler::FileUtils.copy_entry('src1', 'dest1')
tree('dest1')
# => dest1
#    |-- dir0
#    |   |-- src0.txt
#    |   `-- src1.txt
#    `-- dir1
#        |-- src2.txt
#        `-- src3.txt
```

The recursive copying preserves file types for regular files,
directories, and symbolic links;
other file types (FIFO streams, device files, etc.) are not supported.

Optional arguments:

- `dereference_root` - if `src` is a symbolic link,
  follows the link (`false` by default).
- `preserve` - preserves file times (`false` by default).
- `remove_destination` - removes `dest` before copying files (`false` by default).

Related: methods for copying.

### .copy_file(src, dest, preserve = false, dereference = true)

Copies file from `src` to `dest`, which should not be directories.

Arguments `src` and `dest`
should be interpretable as paths.

Examples:

```
Bundler::FileUtils.touch('src0.txt')
Bundler::FileUtils.copy_file('src0.txt', 'dest0.txt')
File.file?('dest0.txt') # => true
```

Optional arguments:

- `dereference` - if `src` is a symbolic link,
  follows the link (`true` by default).
- `preserve` - preserves file times (`false` by default).
- `remove_destination` - removes `dest` before copying files (`false` by default).

Related: methods for copying.

### .copy_stream(src, dest)

Copies IO stream `src` to IO stream `dest` via
[IO.copy_stream](https://docs.ruby-lang.org/en/master/IO.html#method-c-copy_stream).

Related: methods for copying.

### .cp(src, dest, preserve: nil, noop: nil, verbose: nil)

Copies files.

Arguments `src` (a single path or an array of paths)
and `dest` (a single path)
should be interpretable as paths.

If `src` is the path to a file and `dest` is not the path to a directory,
copies `src` to `dest`:

```
Bundler::FileUtils.touch('src0.txt')
File.exist?('dest0.txt') # => false
Bundler::FileUtils.cp('src0.txt', 'dest0.txt')
File.file?('dest0.txt')  # => true
```

If `src` is the path to a file and `dest` is the path to a directory,
copies `src` to `dest/src`:

```
Bundler::FileUtils.touch('src1.txt')
Bundler::FileUtils.mkdir('dest1')
Bundler::FileUtils.cp('src1.txt', 'dest1')
File.file?('dest1/src1.txt') # => true
```

If `src` is an array of paths to files and `dest` is the path to a directory,
copies from each `src` to `dest`:

```
src_file_paths = ['src2.txt', 'src2.dat']
Bundler::FileUtils.touch(src_file_paths)
Bundler::FileUtils.mkdir('dest2')
Bundler::FileUtils.cp(src_file_paths, 'dest2')
File.file?('dest2/src2.txt') # => true
File.file?('dest2/src2.dat') # => true
```

Keyword arguments:

- `preserve: true` - preserves file times.
- `noop: true` - does not copy files.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.cp('src0.txt', 'dest0.txt', noop: true, verbose: true)
Bundler::FileUtils.cp('src1.txt', 'dest1', noop: true, verbose: true)
Bundler::FileUtils.cp(src_file_paths, 'dest2', noop: true, verbose: true)
```

  Output:

```
cp src0.txt dest0.txt
cp src1.txt dest1
cp src2.txt src2.dat dest2
```

Raises an exception if `src` is a directory.

Related: methods for copying.

### .cp_lr(src, dest, noop: nil, verbose: nil, dereference_root: true, remove_destination: false)

Creates [hard links](https://en.wikipedia.org/wiki/Hard_link).

Arguments `src` (a single path or an array of paths)
and `dest` (a single path)
should be interpretable as paths.

If `src` is the path to a directory and `dest` does not exist,
creates links `dest` and descendents pointing to `src` and its descendents:

```
tree('src0')
# => src0
#    |-- sub0
#    |   |-- src0.txt
#    |   `-- src1.txt
#    `-- sub1
#        |-- src2.txt
#        `-- src3.txt
File.exist?('dest0') # => false
Bundler::FileUtils.cp_lr('src0', 'dest0')
tree('dest0')
# => dest0
#    |-- sub0
#    |   |-- src0.txt
#    |   `-- src1.txt
#    `-- sub1
#        |-- src2.txt
#        `-- src3.txt
```

If `src` and `dest` are both paths to directories,
creates links `dest/src` and descendents
pointing to `src` and its descendents:

```
tree('src1')
# => src1
#    |-- sub0
#    |   |-- src0.txt
#    |   `-- src1.txt
#    `-- sub1
#        |-- src2.txt
#        `-- src3.txt
Bundler::FileUtils.mkdir('dest1')
Bundler::FileUtils.cp_lr('src1', 'dest1')
tree('dest1')
# => dest1
#    `-- src1
#        |-- sub0
#        |   |-- src0.txt
#        |   `-- src1.txt
#        `-- sub1
#            |-- src2.txt
#            `-- src3.txt
```

If `src` is an array of paths to entries and `dest` is the path to a directory,
for each path `filepath` in `src`, creates a link at `dest/filepath`
pointing to that path:

```
tree('src2')
# => src2
#    |-- sub0
#    |   |-- src0.txt
#    |   `-- src1.txt
#    `-- sub1
#        |-- src2.txt
#        `-- src3.txt
Bundler::FileUtils.mkdir('dest2')
Bundler::FileUtils.cp_lr(['src2/sub0', 'src2/sub1'], 'dest2')
tree('dest2')
# => dest2
#    |-- sub0
#    |   |-- src0.txt
#    |   `-- src1.txt
#    `-- sub1
#        |-- src2.txt
#        `-- src3.txt
```

Keyword arguments:

- `dereference_root: false` - if `src` is a symbolic link,
  does not dereference it.
- `noop: true` - does not create links.
- `remove_destination: true` - removes `dest` before creating links.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.cp_lr('src0', 'dest0', noop: true, verbose: true)
Bundler::FileUtils.cp_lr('src1', 'dest1', noop: true, verbose: true)
Bundler::FileUtils.cp_lr(['src2/sub0', 'src2/sub1'], 'dest2', noop: true, verbose: true)
```

  Output:

```
cp -lr src0 dest0
cp -lr src1 dest1
cp -lr src2/sub0 src2/sub1 dest2
```

Raises an exception if `dest` is the path to an existing file or directory
and keyword argument `remove_destination: true` is not given.

Related: methods for copying.

### .cp_r(src, dest, preserve: nil, noop: nil, verbose: nil, dereference_root: true, remove_destination: nil)

Recursively copies files.

Arguments `src` (a single path or an array of paths)
and `dest` (a single path)
should be interpretable as paths.

The mode, owner, and group are retained in the copy;
to change those, use Bundler::FileUtils.install instead.

If `src` is the path to a file and `dest` is not the path to a directory,
copies `src` to `dest`:

```
Bundler::FileUtils.touch('src0.txt')
File.exist?('dest0.txt') # => false
Bundler::FileUtils.cp_r('src0.txt', 'dest0.txt')
File.file?('dest0.txt')  # => true
```

If `src` is the path to a file and `dest` is the path to a directory,
copies `src` to `dest/src`:

```
Bundler::FileUtils.touch('src1.txt')
Bundler::FileUtils.mkdir('dest1')
Bundler::FileUtils.cp_r('src1.txt', 'dest1')
File.file?('dest1/src1.txt') # => true
```

If `src` is the path to a directory and `dest` does not exist,
recursively copies `src` to `dest`:

```
tree('src2')
# => src2
#    |-- dir0
#    |   |-- src0.txt
#    |   `-- src1.txt
#    `-- dir1
#    |-- src2.txt
#    `-- src3.txt
Bundler::FileUtils.exist?('dest2') # => false
Bundler::FileUtils.cp_r('src2', 'dest2')
tree('dest2')
# => dest2
#    |-- dir0
#    |   |-- src0.txt
#    |   `-- src1.txt
#    `-- dir1
#    |-- src2.txt
#    `-- src3.txt
```

If `src` and `dest` are paths to directories,
recursively copies `src` to `dest/src`:

```
tree('src3')
# => src3
#    |-- dir0
#    |   |-- src0.txt
#    |   `-- src1.txt
#    `-- dir1
#    |-- src2.txt
#    `-- src3.txt
Bundler::FileUtils.mkdir('dest3')
Bundler::FileUtils.cp_r('src3', 'dest3')
tree('dest3')
# => dest3
#    `-- src3
#      |-- dir0
#      |   |-- src0.txt
#      |   `-- src1.txt
#      `-- dir1
#          |-- src2.txt
#          `-- src3.txt
```

If `src` is an array of paths and `dest` is a directory,
recursively copies from each path in `src` to `dest`;
the paths in `src` may point to files and/or directories.

Keyword arguments:

- `dereference_root: false` - if `src` is a symbolic link,
  does not dereference it.
- `noop: true` - does not copy files.
- `preserve: true` - preserves file times.
- `remove_destination: true` - removes `dest` before copying files.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.cp_r('src0.txt', 'dest0.txt', noop: true, verbose: true)
Bundler::FileUtils.cp_r('src1.txt', 'dest1', noop: true, verbose: true)
Bundler::FileUtils.cp_r('src2', 'dest2', noop: true, verbose: true)
Bundler::FileUtils.cp_r('src3', 'dest3', noop: true, verbose: true)
```

  Output:

```
cp -r src0.txt dest0.txt
cp -r src1.txt dest1
cp -r src2 dest2
cp -r src3 dest3
```

Raises an exception of `src` is the path to a directory
and `dest` is the path to a file.

Related: methods for copying.

### .getwd

Returns a string containing the path to the current directory:

```
Bundler::FileUtils.pwd # => "/rdoc/fileutils"
```

Related: Bundler::FileUtils.cd.

### .have_option?(mid, opt)

Returns `true` if method `mid` accepts the given option `opt`, `false` otherwise;
the arguments may be strings or symbols:

```
Bundler::FileUtils.have_option?(:chmod, :noop) # => true
Bundler::FileUtils.have_option?('chmod', 'secure') # => false
```

Returns: `Boolean`

### .identical?

Returns `true` if the contents of files `a` and `b` are identical,
`false` otherwise.

Arguments `a` and `b`
should be interpretable as a path.

Bundler::FileUtils.identical? and Bundler::FileUtils.cmp are aliases for Bundler::FileUtils.compare_file.

Related: Bundler::FileUtils.compare_stream.

### .install(src, dest, mode: nil, owner: nil, group: nil, preserve: nil, noop: nil, verbose: nil)

Copies a file entry.
See [install(1)](https://man7.org/linux/man-pages/man1/install.1.html).

Arguments `src` (a single path or an array of paths)
and `dest` (a single path)
should be interpretable as paths;

If the entry at `dest` does not exist, copies from `src` to `dest`:

```
File.read('src0.txt')    # => "aaa\n"
File.exist?('dest0.txt') # => false
Bundler::FileUtils.install('src0.txt', 'dest0.txt')
File.read('dest0.txt')   # => "aaa\n"
```

If `dest` is a file entry, copies from `src` to `dest`, overwriting:

```
File.read('src1.txt')  # => "aaa\n"
File.read('dest1.txt') # => "bbb\n"
Bundler::FileUtils.install('src1.txt', 'dest1.txt')
File.read('dest1.txt') # => "aaa\n"
```

If `dest` is a directory entry, copies from `src` to `dest/src`,
overwriting if necessary:

```
File.read('src2.txt')       # => "aaa\n"
File.read('dest2/src2.txt') # => "bbb\n"
Bundler::FileUtils.install('src2.txt', 'dest2')
File.read('dest2/src2.txt') # => "aaa\n"
```

If `src` is an array of paths and `dest` points to a directory,
copies each path `path` in `src` to `dest/path`:

```
File.file?('src3.txt') # => true
File.file?('src3.dat') # => true
Bundler::FileUtils.mkdir('dest3')
Bundler::FileUtils.install(['src3.txt', 'src3.dat'], 'dest3')
File.file?('dest3/src3.txt') # => true
File.file?('dest3/src3.dat') # => true
```

Keyword arguments:

- `group: *group*` - changes the group if not `nil`,
  using [File.chown](https://docs.ruby-lang.org/en/master/File.html#method-c-chown).
- `mode: *permissions*` - changes the permissions.
  using [File.chmod](https://docs.ruby-lang.org/en/master/File.html#method-c-chmod).
- `noop: true` - does not copy entries; returns `nil`.
- `owner: *owner*` - changes the owner if not `nil`,
  using [File.chown](https://docs.ruby-lang.org/en/master/File.html#method-c-chown).
- `preserve: true` - preserve timestamps
  using [File.utime](https://docs.ruby-lang.org/en/master/File.html#method-c-utime).
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.install('src0.txt', 'dest0.txt', noop: true, verbose: true)
Bundler::FileUtils.install('src1.txt', 'dest1.txt', noop: true, verbose: true)
Bundler::FileUtils.install('src2.txt', 'dest2', noop: true, verbose: true)
```

  Output:

```
install -c src0.txt dest0.txt
install -c src1.txt dest1.txt
install -c src2.txt dest2
```

Related: methods for copying.

### .link

Creates [hard links](https://en.wikipedia.org/wiki/Hard_link).

Arguments `src` (a single path or an array of paths)
and `dest` (a single path)
should be interpretable as paths.

When `src` is the path to an existing file
and `dest` is the path to a non-existent file,
creates a hard link at `dest` pointing to `src`; returns zero:

```
Dir.children('tmp0/')                    # => ["t.txt"]
Dir.children('tmp1/')                    # => []
Bundler::FileUtils.ln('tmp0/t.txt', 'tmp1/t.lnk') # => 0
Dir.children('tmp1/')                    # => ["t.lnk"]
```

When `src` is the path to an existing file
and `dest` is the path to an existing directory,
creates a hard link at `dest/src` pointing to `src`; returns zero:

```
Dir.children('tmp2')               # => ["t.dat"]
Dir.children('tmp3')               # => []
Bundler::FileUtils.ln('tmp2/t.dat', 'tmp3') # => 0
Dir.children('tmp3')               # => ["t.dat"]
```

When `src` is an array of paths to existing files
and `dest` is the path to an existing directory,
then for each path `target` in `src`,
creates a hard link at `dest/target` pointing to `target`;
returns `src`:

```
Dir.children('tmp4/')                               # => []
Bundler::FileUtils.ln(['tmp0/t.txt', 'tmp2/t.dat'], 'tmp4/') # => ["tmp0/t.txt", "tmp2/t.dat"]
Dir.children('tmp4/')                               # => ["t.dat", "t.txt"]
```

Keyword arguments:

- `force: true` - overwrites `dest` if it exists.
- `noop: true` - does not create links.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.ln('tmp0/t.txt', 'tmp1/t.lnk', verbose: true)
Bundler::FileUtils.ln('tmp2/t.dat', 'tmp3', verbose: true)
Bundler::FileUtils.ln(['tmp0/t.txt', 'tmp2/t.dat'], 'tmp4/', verbose: true)
```

  Output:

```
ln tmp0/t.txt tmp1/t.lnk
ln tmp2/t.dat tmp3
ln tmp0/t.txt tmp2/t.dat tmp4/
```

Raises an exception if `dest` is the path to an existing file
and keyword argument `force` is not `true`.

Related: Bundler::FileUtils.link_entry (has different options).

### .link_entry(src, dest, dereference_root = false, remove_destination = false)

Creates [hard links](https://en.wikipedia.org/wiki/Hard_link); returns `nil`.

Arguments `src` and `dest`
should be interpretable as paths.

If `src` is the path to a file and `dest` does not exist,
creates a hard link at `dest` pointing to `src`:

```
Bundler::FileUtils.touch('src0.txt')
File.exist?('dest0.txt') # => false
Bundler::FileUtils.link_entry('src0.txt', 'dest0.txt')
File.file?('dest0.txt')  # => true
```

If `src` is the path to a directory and `dest` does not exist,
recursively creates hard links at `dest` pointing to paths in `src`:

```
Bundler::FileUtils.mkdir_p(['src1/dir0', 'src1/dir1'])
src_file_paths = [
  'src1/dir0/t0.txt',
  'src1/dir0/t1.txt',
  'src1/dir1/t2.txt',
  'src1/dir1/t3.txt',
  ]
Bundler::FileUtils.touch(src_file_paths)
File.directory?('dest1')        # => true
Bundler::FileUtils.link_entry('src1', 'dest1')
File.file?('dest1/dir0/t0.txt') # => true
File.file?('dest1/dir0/t1.txt') # => true
File.file?('dest1/dir1/t2.txt') # => true
File.file?('dest1/dir1/t3.txt') # => true
```

Optional arguments:

- `dereference_root` - dereferences `src` if it is a symbolic link (`false` by default).
- `remove_destination` - removes `dest` before creating links (`false` by default).

Raises an exception if `dest` is the path to an existing file or directory
and optional argument `remove_destination` is not given.

Related: Bundler::FileUtils.ln (has different options).

### .ln(src, dest, force: nil, noop: nil, verbose: nil)

Creates [hard links](https://en.wikipedia.org/wiki/Hard_link).

Arguments `src` (a single path or an array of paths)
and `dest` (a single path)
should be interpretable as paths.

When `src` is the path to an existing file
and `dest` is the path to a non-existent file,
creates a hard link at `dest` pointing to `src`; returns zero:

```
Dir.children('tmp0/')                    # => ["t.txt"]
Dir.children('tmp1/')                    # => []
Bundler::FileUtils.ln('tmp0/t.txt', 'tmp1/t.lnk') # => 0
Dir.children('tmp1/')                    # => ["t.lnk"]
```

When `src` is the path to an existing file
and `dest` is the path to an existing directory,
creates a hard link at `dest/src` pointing to `src`; returns zero:

```
Dir.children('tmp2')               # => ["t.dat"]
Dir.children('tmp3')               # => []
Bundler::FileUtils.ln('tmp2/t.dat', 'tmp3') # => 0
Dir.children('tmp3')               # => ["t.dat"]
```

When `src` is an array of paths to existing files
and `dest` is the path to an existing directory,
then for each path `target` in `src`,
creates a hard link at `dest/target` pointing to `target`;
returns `src`:

```
Dir.children('tmp4/')                               # => []
Bundler::FileUtils.ln(['tmp0/t.txt', 'tmp2/t.dat'], 'tmp4/') # => ["tmp0/t.txt", "tmp2/t.dat"]
Dir.children('tmp4/')                               # => ["t.dat", "t.txt"]
```

Keyword arguments:

- `force: true` - overwrites `dest` if it exists.
- `noop: true` - does not create links.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.ln('tmp0/t.txt', 'tmp1/t.lnk', verbose: true)
Bundler::FileUtils.ln('tmp2/t.dat', 'tmp3', verbose: true)
Bundler::FileUtils.ln(['tmp0/t.txt', 'tmp2/t.dat'], 'tmp4/', verbose: true)
```

  Output:

```
ln tmp0/t.txt tmp1/t.lnk
ln tmp2/t.dat tmp3
ln tmp0/t.txt tmp2/t.dat tmp4/
```

Raises an exception if `dest` is the path to an existing file
and keyword argument `force` is not `true`.

Related: Bundler::FileUtils.link_entry (has different options).

### .ln_s(src, dest, force: nil, relative: false, target_directory: true, noop: nil, verbose: nil)

Creates [symbolic links](https://en.wikipedia.org/wiki/Symbolic_link).

Arguments `src` (a single path or an array of paths)
and `dest` (a single path)
should be interpretable as paths.

If `src` is the path to an existing file:

- When `dest` is the path to a non-existent file,
  creates a symbolic link at `dest` pointing to `src`:

```
Bundler::FileUtils.touch('src0.txt')
File.exist?('dest0.txt')   # => false
Bundler::FileUtils.ln_s('src0.txt', 'dest0.txt')
File.symlink?('dest0.txt') # => true
```

- When `dest` is the path to an existing file,
  creates a symbolic link at `dest` pointing to `src`
  if and only if keyword argument `force: true` is given
  (raises an exception otherwise):

```
Bundler::FileUtils.touch('src1.txt')
Bundler::FileUtils.touch('dest1.txt')
Bundler::FileUtils.ln_s('src1.txt', 'dest1.txt', force: true)
FileTest.symlink?('dest1.txt') # => true

Bundler::FileUtils.ln_s('src1.txt', 'dest1.txt') # Raises Errno::EEXIST.
```

If `dest` is the path to a directory,
creates a symbolic link at `dest/src` pointing to `src`:

```
Bundler::FileUtils.touch('src2.txt')
Bundler::FileUtils.mkdir('destdir2')
Bundler::FileUtils.ln_s('src2.txt', 'destdir2')
File.symlink?('destdir2/src2.txt') # => true
```

If `src` is an array of paths to existing files and `dest` is a directory,
for each child `child` in `src` creates a symbolic link `dest/child`
pointing to `child`:

```
Bundler::FileUtils.mkdir('srcdir3')
Bundler::FileUtils.touch('srcdir3/src0.txt')
Bundler::FileUtils.touch('srcdir3/src1.txt')
Bundler::FileUtils.mkdir('destdir3')
Bundler::FileUtils.ln_s(['srcdir3/src0.txt', 'srcdir3/src1.txt'], 'destdir3')
File.symlink?('destdir3/src0.txt') # => true
File.symlink?('destdir3/src1.txt') # => true
```

Keyword arguments:

- `force: true` - overwrites `dest` if it exists.
- `relative: false` - create links relative to `dest`.
- `noop: true` - does not create links.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.ln_s('src0.txt', 'dest0.txt', noop: true, verbose: true)
Bundler::FileUtils.ln_s('src1.txt', 'destdir1', noop: true, verbose: true)
Bundler::FileUtils.ln_s('src2.txt', 'dest2.txt', force: true, noop: true, verbose: true)
Bundler::FileUtils.ln_s(['srcdir3/src0.txt', 'srcdir3/src1.txt'], 'destdir3', noop: true, verbose: true)
```

  Output:

```
ln -s src0.txt dest0.txt
ln -s src1.txt destdir1
ln -sf src2.txt dest2.txt
ln -s srcdir3/src0.txt srcdir3/src1.txt destdir3
```

Related: Bundler::FileUtils.ln_sf.

### .ln_sf(src, dest, noop: nil, verbose: nil)

Like Bundler::FileUtils.ln_s, but always with keyword argument `force: true` given.

### .ln_sr(src, dest, target_directory: true, force: nil, noop: nil, verbose: nil)

Like Bundler::FileUtils.ln_s, but create links relative to `dest`.

### .makedirs

Creates directories at the paths in the given `list`
(a single path or an array of paths),
also creating ancestor directories as needed;
returns `list` if it is an array, `[list]` otherwise.

Argument `list` or its elements
should be interpretable as paths.

With no keyword arguments, creates a directory at each `path` in `list`,
along with any needed ancestor directories,
by calling: `Dir.mkdir(path, mode)`;
see [Dir.mkdir](https://docs.ruby-lang.org/en/master/Dir.html#method-c-mkdir):

```
Bundler::FileUtils.mkdir_p(%w[tmp0/tmp1 tmp2/tmp3]) # => ["tmp0/tmp1", "tmp2/tmp3"]
Bundler::FileUtils.mkdir_p('tmp4/tmp5')             # => ["tmp4/tmp5"]
```

Keyword arguments:

- `mode: *mode*` - also calls `File.chmod(mode, path)`;
  see [File.chmod](https://docs.ruby-lang.org/en/master/File.html#method-c-chmod).
- `noop: true` - does not create directories.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.mkdir_p(%w[tmp0 tmp1], verbose: true)
Bundler::FileUtils.mkdir_p(%w[tmp2 tmp3], mode: 0700, verbose: true)
```

  Output:

```
mkdir -p tmp0 tmp1
mkdir -p -m 700 tmp2 tmp3
```

Raises an exception if for any reason a directory cannot be created.

Bundler::FileUtils.mkpath and Bundler::FileUtils.makedirs are aliases for Bundler::FileUtils.mkdir_p.

Related: Bundler::FileUtils.mkdir.

### .mkdir(list, mode: nil, noop: nil, verbose: nil)

Creates directories at the paths in the given `list`
(a single path or an array of paths);
returns `list` if it is an array, `[list]` otherwise.

Argument `list` or its elements
should be interpretable as paths.

With no keyword arguments, creates a directory at each `path` in `list`
by calling: `Dir.mkdir(path, mode)`;
see [Dir.mkdir](https://docs.ruby-lang.org/en/master/Dir.html#method-c-mkdir):

```
Bundler::FileUtils.mkdir(%w[tmp0 tmp1]) # => ["tmp0", "tmp1"]
Bundler::FileUtils.mkdir('tmp4')        # => ["tmp4"]
```

Keyword arguments:

- `mode: *mode*` - also calls `File.chmod(mode, path)`;
  see [File.chmod](https://docs.ruby-lang.org/en/master/File.html#method-c-chmod).
- `noop: true` - does not create directories.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.mkdir(%w[tmp0 tmp1], verbose: true)
Bundler::FileUtils.mkdir(%w[tmp2 tmp3], mode: 0700, verbose: true)
```

  Output:

```
mkdir tmp0 tmp1
mkdir -m 700 tmp2 tmp3
```

Raises an exception if any path points to an existing
file or directory, or if for any reason a directory cannot be created.

Related: Bundler::FileUtils.mkdir_p.

### .mkdir_p(list, mode: nil, noop: nil, verbose: nil)

Creates directories at the paths in the given `list`
(a single path or an array of paths),
also creating ancestor directories as needed;
returns `list` if it is an array, `[list]` otherwise.

Argument `list` or its elements
should be interpretable as paths.

With no keyword arguments, creates a directory at each `path` in `list`,
along with any needed ancestor directories,
by calling: `Dir.mkdir(path, mode)`;
see [Dir.mkdir](https://docs.ruby-lang.org/en/master/Dir.html#method-c-mkdir):

```
Bundler::FileUtils.mkdir_p(%w[tmp0/tmp1 tmp2/tmp3]) # => ["tmp0/tmp1", "tmp2/tmp3"]
Bundler::FileUtils.mkdir_p('tmp4/tmp5')             # => ["tmp4/tmp5"]
```

Keyword arguments:

- `mode: *mode*` - also calls `File.chmod(mode, path)`;
  see [File.chmod](https://docs.ruby-lang.org/en/master/File.html#method-c-chmod).
- `noop: true` - does not create directories.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.mkdir_p(%w[tmp0 tmp1], verbose: true)
Bundler::FileUtils.mkdir_p(%w[tmp2 tmp3], mode: 0700, verbose: true)
```

  Output:

```
mkdir -p tmp0 tmp1
mkdir -p -m 700 tmp2 tmp3
```

Raises an exception if for any reason a directory cannot be created.

Bundler::FileUtils.mkpath and Bundler::FileUtils.makedirs are aliases for Bundler::FileUtils.mkdir_p.

Related: Bundler::FileUtils.mkdir.

### .mkpath

Creates directories at the paths in the given `list`
(a single path or an array of paths),
also creating ancestor directories as needed;
returns `list` if it is an array, `[list]` otherwise.

Argument `list` or its elements
should be interpretable as paths.

With no keyword arguments, creates a directory at each `path` in `list`,
along with any needed ancestor directories,
by calling: `Dir.mkdir(path, mode)`;
see [Dir.mkdir](https://docs.ruby-lang.org/en/master/Dir.html#method-c-mkdir):

```
Bundler::FileUtils.mkdir_p(%w[tmp0/tmp1 tmp2/tmp3]) # => ["tmp0/tmp1", "tmp2/tmp3"]
Bundler::FileUtils.mkdir_p('tmp4/tmp5')             # => ["tmp4/tmp5"]
```

Keyword arguments:

- `mode: *mode*` - also calls `File.chmod(mode, path)`;
  see [File.chmod](https://docs.ruby-lang.org/en/master/File.html#method-c-chmod).
- `noop: true` - does not create directories.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.mkdir_p(%w[tmp0 tmp1], verbose: true)
Bundler::FileUtils.mkdir_p(%w[tmp2 tmp3], mode: 0700, verbose: true)
```

  Output:

```
mkdir -p tmp0 tmp1
mkdir -p -m 700 tmp2 tmp3
```

Raises an exception if for any reason a directory cannot be created.

Bundler::FileUtils.mkpath and Bundler::FileUtils.makedirs are aliases for Bundler::FileUtils.mkdir_p.

Related: Bundler::FileUtils.mkdir.

### .move

Moves entries.

Arguments `src` (a single path or an array of paths)
and `dest` (a single path)
should be interpretable as paths.

If `src` and `dest` are on different file systems,
first copies, then removes `src`.

May cause a local vulnerability if not called with keyword argument
`secure: true`;
see Avoiding the TOCTTOU Vulnerability.

If `src` is the path to a single file or directory and `dest` does not exist,
moves `src` to `dest`:

```
tree('src0')
# => src0
#    |-- src0.txt
#    `-- src1.txt
File.exist?('dest0') # => false
Bundler::FileUtils.mv('src0', 'dest0')
File.exist?('src0')  # => false
tree('dest0')
# => dest0
#    |-- src0.txt
#    `-- src1.txt
```

If `src` is an array of paths to files and directories
and `dest` is the path to a directory,
copies from each path in the array to `dest`:

```
File.file?('src1.txt') # => true
tree('src1')
# => src1
#    |-- src.dat
#    `-- src.txt
Dir.empty?('dest1')    # => true
Bundler::FileUtils.mv(['src1.txt', 'src1'], 'dest1')
tree('dest1')
# => dest1
#    |-- src1
#    |   |-- src.dat
#    |   `-- src.txt
#    `-- src1.txt
```

Keyword arguments:

- `force: true` - if the move includes removing `src`
  (that is, if `src` and `dest` are on different file systems),
  ignores raised exceptions of StandardError and its descendants.
- `noop: true` - does not move files.
- `secure: true` - removes `src` securely;
  see details at Bundler::FileUtils.remove_entry_secure.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.mv('src0', 'dest0', noop: true, verbose: true)
Bundler::FileUtils.mv(['src1.txt', 'src1'], 'dest1', noop: true, verbose: true)
```

  Output:

```
mv src0 dest0
mv src1.txt src1 dest1
```

### .mv(src, dest, force: nil, noop: nil, verbose: nil, secure: nil)

Moves entries.

Arguments `src` (a single path or an array of paths)
and `dest` (a single path)
should be interpretable as paths.

If `src` and `dest` are on different file systems,
first copies, then removes `src`.

May cause a local vulnerability if not called with keyword argument
`secure: true`;
see Avoiding the TOCTTOU Vulnerability.

If `src` is the path to a single file or directory and `dest` does not exist,
moves `src` to `dest`:

```
tree('src0')
# => src0
#    |-- src0.txt
#    `-- src1.txt
File.exist?('dest0') # => false
Bundler::FileUtils.mv('src0', 'dest0')
File.exist?('src0')  # => false
tree('dest0')
# => dest0
#    |-- src0.txt
#    `-- src1.txt
```

If `src` is an array of paths to files and directories
and `dest` is the path to a directory,
copies from each path in the array to `dest`:

```
File.file?('src1.txt') # => true
tree('src1')
# => src1
#    |-- src.dat
#    `-- src.txt
Dir.empty?('dest1')    # => true
Bundler::FileUtils.mv(['src1.txt', 'src1'], 'dest1')
tree('dest1')
# => dest1
#    |-- src1
#    |   |-- src.dat
#    |   `-- src.txt
#    `-- src1.txt
```

Keyword arguments:

- `force: true` - if the move includes removing `src`
  (that is, if `src` and `dest` are on different file systems),
  ignores raised exceptions of StandardError and its descendants.
- `noop: true` - does not move files.
- `secure: true` - removes `src` securely;
  see details at Bundler::FileUtils.remove_entry_secure.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.mv('src0', 'dest0', noop: true, verbose: true)
Bundler::FileUtils.mv(['src1.txt', 'src1'], 'dest1', noop: true, verbose: true)
```

  Output:

```
mv src0 dest0
mv src1.txt src1 dest1
```

### .options

Returns an array of the string keyword names:

```
Bundler::FileUtils.options.take(3) # => ["noop", "verbose", "force"]
```

### .options_of(mid)

Returns an array of the string keyword name for method `mid`;
the argument may be a string or a symbol:

```
Bundler::FileUtils.options_of(:rm) # => ["force", "noop", "verbose"]
Bundler::FileUtils.options_of('mv') # => ["force", "noop", "verbose", "secure"]
```

### .private_module_function(name)

### .pwd

Returns a string containing the path to the current directory:

```
Bundler::FileUtils.pwd # => "/rdoc/fileutils"
```

Related: Bundler::FileUtils.cd.

### .remove

Removes entries at the paths in the given `list`
(a single path or an array of paths)
returns `list`, if it is an array, `[list]` otherwise.

Argument `list` or its elements
should be interpretable as paths.

With no keyword arguments, removes files at the paths given in `list`:

```
Bundler::FileUtils.touch(['src0.txt', 'src0.dat'])
Bundler::FileUtils.rm(['src0.dat', 'src0.txt']) # => ["src0.dat", "src0.txt"]
```

Keyword arguments:

- `force: true` - ignores raised exceptions of StandardError
  and its descendants.
- `noop: true` - does not remove files; returns `nil`.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.rm(['src0.dat', 'src0.txt'], noop: true, verbose: true)
```

  Output:

```
rm src0.dat src0.txt
```

Related: methods for deleting.

### .remove_dir(path, force = false)

Recursively removes the directory entry given by `path`,
which should be the entry for a regular file, a symbolic link,
or a directory.

Argument `path`
should be interpretable as a path.

Optional argument `force` specifies whether to ignore
raised exceptions of StandardError and its descendants.

Related: methods for deleting.

Raises: `Errno::ENOTDIR`

### .remove_entry(path, force = false)

Removes the entry given by `path`,
which should be the entry for a regular file, a symbolic link,
or a directory.

Argument `path`
should be interpretable as a path.

Optional argument `force` specifies whether to ignore
raised exceptions of StandardError and its descendants.

Related: Bundler::FileUtils.remove_entry_secure.

### .remove_entry_secure(path, force = false)

Securely removes the entry given by `path`,
which should be the entry for a regular file, a symbolic link,
or a directory.

Argument `path`
should be interpretable as a path.

Avoids a local vulnerability that can exist in certain circumstances;
see Avoiding the TOCTTOU Vulnerability.

Optional argument `force` specifies whether to ignore
raised exceptions of StandardError and its descendants.

Related: methods for deleting.

### .remove_file(path, force = false)

Removes the file entry given by `path`,
which should be the entry for a regular file or a symbolic link.

Argument `path`
should be interpretable as a path.

Optional argument `force` specifies whether to ignore
raised exceptions of StandardError and its descendants.

Related: methods for deleting.

### .rm(list, force: nil, noop: nil, verbose: nil)

Removes entries at the paths in the given `list`
(a single path or an array of paths)
returns `list`, if it is an array, `[list]` otherwise.

Argument `list` or its elements
should be interpretable as paths.

With no keyword arguments, removes files at the paths given in `list`:

```
Bundler::FileUtils.touch(['src0.txt', 'src0.dat'])
Bundler::FileUtils.rm(['src0.dat', 'src0.txt']) # => ["src0.dat", "src0.txt"]
```

Keyword arguments:

- `force: true` - ignores raised exceptions of StandardError
  and its descendants.
- `noop: true` - does not remove files; returns `nil`.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.rm(['src0.dat', 'src0.txt'], noop: true, verbose: true)
```

  Output:

```
rm src0.dat src0.txt
```

Related: methods for deleting.

### .rm_f(list, noop: nil, verbose: nil)

Equivalent to:

```
Bundler::FileUtils.rm(list, force: true, **kwargs)
```

Argument `list` (a single path or an array of paths)
should be interpretable as paths.

See Bundler::FileUtils.rm for keyword arguments.

Related: methods for deleting.

### .rm_r(list, force: nil, noop: nil, verbose: nil, secure: nil)

Removes entries at the paths in the given `list`
(a single path or an array of paths);
returns `list`, if it is an array, `[list]` otherwise.

Argument `list` or its elements
should be interpretable as paths.

May cause a local vulnerability if not called with keyword argument
`secure: true`;
see Avoiding the TOCTTOU Vulnerability.

For each file path, removes the file at that path:

```
Bundler::FileUtils.touch(['src0.txt', 'src0.dat'])
Bundler::FileUtils.rm_r(['src0.dat', 'src0.txt'])
File.exist?('src0.txt') # => false
File.exist?('src0.dat') # => false
```

For each directory path, recursively removes files and directories:

```
tree('src1')
# => src1
#    |-- dir0
#    |   |-- src0.txt
#    |   `-- src1.txt
#    `-- dir1
#        |-- src2.txt
#        `-- src3.txt
Bundler::FileUtils.rm_r('src1')
File.exist?('src1') # => false
```

Keyword arguments:

- `force: true` - ignores raised exceptions of StandardError
  and its descendants.
- `noop: true` - does not remove entries; returns `nil`.
- `secure: true` - removes `src` securely;
  see details at Bundler::FileUtils.remove_entry_secure.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.rm_r(['src0.dat', 'src0.txt'], noop: true, verbose: true)
Bundler::FileUtils.rm_r('src1', noop: true, verbose: true)
```

  Output:

```
rm -r src0.dat src0.txt
rm -r src1
```

Related: methods for deleting.

### .rm_rf(list, noop: nil, verbose: nil, secure: nil)

Equivalent to:

```
Bundler::FileUtils.rm_r(list, force: true, **kwargs)
```

Argument `list` or its elements
should be interpretable as paths.

May cause a local vulnerability if not called with keyword argument
`secure: true`;
see Avoiding the TOCTTOU Vulnerability.

See Bundler::FileUtils.rm_r for keyword arguments.

Related: methods for deleting.

### .rmdir(list, parents: nil, noop: nil, verbose: nil)

Removes directories at the paths in the given `list`
(a single path or an array of paths);
returns `list`, if it is an array, `[list]` otherwise.

Argument `list` or its elements
should be interpretable as paths.

With no keyword arguments, removes the directory at each `path` in `list`,
by calling: `Dir.rmdir(path)`;
see [Dir.rmdir](https://docs.ruby-lang.org/en/master/Dir.html#method-c-rmdir):

```
Bundler::FileUtils.rmdir(%w[tmp0/tmp1 tmp2/tmp3]) # => ["tmp0/tmp1", "tmp2/tmp3"]
Bundler::FileUtils.rmdir('tmp4/tmp5')             # => ["tmp4/tmp5"]
```

Keyword arguments:

- `parents: true` - removes successive ancestor directories
  if empty.
- `noop: true` - does not remove directories.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.rmdir(%w[tmp0/tmp1 tmp2/tmp3], parents: true, verbose: true)
Bundler::FileUtils.rmdir('tmp4/tmp5', parents: true, verbose: true)
```

  Output:

```
rmdir -p tmp0/tmp1 tmp2/tmp3
rmdir -p tmp4/tmp5
```

Raises an exception if a directory does not exist
or if for any reason a directory cannot be removed.

Related: methods for deleting.

### .rmtree

Equivalent to:

```
Bundler::FileUtils.rm_r(list, force: true, **kwargs)
```

Argument `list` or its elements
should be interpretable as paths.

May cause a local vulnerability if not called with keyword argument
`secure: true`;
see Avoiding the TOCTTOU Vulnerability.

See Bundler::FileUtils.rm_r for keyword arguments.

Related: methods for deleting.

### .safe_unlink

Equivalent to:

```
Bundler::FileUtils.rm(list, force: true, **kwargs)
```

Argument `list` (a single path or an array of paths)
should be interpretable as paths.

See Bundler::FileUtils.rm for keyword arguments.

Related: methods for deleting.

### .symlink

Creates [symbolic links](https://en.wikipedia.org/wiki/Symbolic_link).

Arguments `src` (a single path or an array of paths)
and `dest` (a single path)
should be interpretable as paths.

If `src` is the path to an existing file:

- When `dest` is the path to a non-existent file,
  creates a symbolic link at `dest` pointing to `src`:

```
Bundler::FileUtils.touch('src0.txt')
File.exist?('dest0.txt')   # => false
Bundler::FileUtils.ln_s('src0.txt', 'dest0.txt')
File.symlink?('dest0.txt') # => true
```

- When `dest` is the path to an existing file,
  creates a symbolic link at `dest` pointing to `src`
  if and only if keyword argument `force: true` is given
  (raises an exception otherwise):

```
Bundler::FileUtils.touch('src1.txt')
Bundler::FileUtils.touch('dest1.txt')
Bundler::FileUtils.ln_s('src1.txt', 'dest1.txt', force: true)
FileTest.symlink?('dest1.txt') # => true

Bundler::FileUtils.ln_s('src1.txt', 'dest1.txt') # Raises Errno::EEXIST.
```

If `dest` is the path to a directory,
creates a symbolic link at `dest/src` pointing to `src`:

```
Bundler::FileUtils.touch('src2.txt')
Bundler::FileUtils.mkdir('destdir2')
Bundler::FileUtils.ln_s('src2.txt', 'destdir2')
File.symlink?('destdir2/src2.txt') # => true
```

If `src` is an array of paths to existing files and `dest` is a directory,
for each child `child` in `src` creates a symbolic link `dest/child`
pointing to `child`:

```
Bundler::FileUtils.mkdir('srcdir3')
Bundler::FileUtils.touch('srcdir3/src0.txt')
Bundler::FileUtils.touch('srcdir3/src1.txt')
Bundler::FileUtils.mkdir('destdir3')
Bundler::FileUtils.ln_s(['srcdir3/src0.txt', 'srcdir3/src1.txt'], 'destdir3')
File.symlink?('destdir3/src0.txt') # => true
File.symlink?('destdir3/src1.txt') # => true
```

Keyword arguments:

- `force: true` - overwrites `dest` if it exists.
- `relative: false` - create links relative to `dest`.
- `noop: true` - does not create links.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.ln_s('src0.txt', 'dest0.txt', noop: true, verbose: true)
Bundler::FileUtils.ln_s('src1.txt', 'destdir1', noop: true, verbose: true)
Bundler::FileUtils.ln_s('src2.txt', 'dest2.txt', force: true, noop: true, verbose: true)
Bundler::FileUtils.ln_s(['srcdir3/src0.txt', 'srcdir3/src1.txt'], 'destdir3', noop: true, verbose: true)
```

  Output:

```
ln -s src0.txt dest0.txt
ln -s src1.txt destdir1
ln -sf src2.txt dest2.txt
ln -s srcdir3/src0.txt srcdir3/src1.txt destdir3
```

Related: Bundler::FileUtils.ln_sf.

### .touch(list, noop: nil, verbose: nil, mtime: nil, nocreate: nil)

Updates modification times (mtime) and access times (atime)
of the entries given by the paths in `list`
(a single path or an array of paths);
returns `list` if it is an array, `[list]` otherwise.

By default, creates an empty file for any path to a non-existent entry;
use keyword argument `nocreate` to raise an exception instead.

Argument `list` or its elements
should be interpretable as paths.

Examples:

```
# Single path.
f = File.new('src0.txt') # Existing file.
f.atime # => 2022-06-10 11:11:21.200277 -0700
f.mtime # => 2022-06-10 11:11:21.200277 -0700
Bundler::FileUtils.touch('src0.txt')
f = File.new('src0.txt')
f.atime # => 2022-06-11 08:28:09.8185343 -0700
f.mtime # => 2022-06-11 08:28:09.8185343 -0700

# Array of paths.
Bundler::FileUtils.touch(['src0.txt', 'src0.dat'])
```

Keyword arguments:

- `mtime: *time*` - sets the entry's mtime to the given time,
  instead of the current time.
- `nocreate: true` - raises an exception if the entry does not exist.
- `noop: true` - does not touch entries; returns `nil`.
- `verbose: true` - prints an equivalent command:

```
Bundler::FileUtils.touch('src0.txt', noop: true, verbose: true)
Bundler::FileUtils.touch(['src0.txt', 'src0.dat'], noop: true, verbose: true)
Bundler::FileUtils.touch(path, noop: true, verbose: true)
```

  Output:

```
touch src0.txt
touch src0.txt src0.dat
touch src0.txt
```

Related: Bundler::FileUtils.uptodate?.

### .uptodate?(new, old_list)

Returns `true` if the file at path `new`
is newer than all the files at paths in array `old_list`;
`false` otherwise.

Argument `new` and the elements of `old_list`
should be interpretable as paths:

```
Bundler::FileUtils.uptodate?('Rakefile', ['Gemfile', 'README.md']) # => true
Bundler::FileUtils.uptodate?('Gemfile', ['Rakefile', 'README.md']) # => false
```

A non-existent file is considered to be infinitely old.

Related: Bundler::FileUtils.touch.

Returns: `Boolean`

## Instance methods

### #apply_mask(mode, user_mask, op, mode_mask)

### #fu_get_gid(group)

### #fu_get_uid(user)

### #fu_have_symlink?

Returns: `Boolean`

### #fu_mkdir(path, mode)

### #fu_mode(mode, path)

### #fu_stat_identical_entry?(a, b)

Returns: `Boolean`

### #mode_to_s(mode)

### #remove_trailing_slash(dir)

### #symbolic_modes_to_i(mode_sym, path)

### #user_mask(target)
