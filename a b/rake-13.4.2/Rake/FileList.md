# class Rake::FileList
Includes: `Rake::Cloneable`
Defined in: `lib/rake/file_list.rb`

A FileList is essentially an array with a few helper methods defined to
make file manipulation a bit easier.

FileLists are lazy.  When given a list of glob patterns for possible files
to be included in the file list, instead of searching the file structures
to find the files, a FileList holds the pattern for latter use.

This allows us to define a number of FileList to match any number of
files, but only search out the actual files when then FileList itself is
actually used.  The key is that the first time an element of the
FileList/Array is requested, the pending patterns are resolved into a real
list of file names.

## Constants

### ARRAY_METHODS = (Array.instance_methods - Object.instance_methods).map(&:to_s)

List of array methods (that are not in `Object`) that need to be
delegated.

### DEFAULT_IGNORE_PATTERNS

```ruby
DEFAULT_IGNORE_PATTERNS = [
  /(^|[\/\\])CVS([\/\\]|$)/,
  /(^|[\/\\])\.svn([\/\\]|$)/,
  /\.bak$/,
  /~$/
]
```

### DEFAULT_IGNORE_PROCS

```ruby
DEFAULT_IGNORE_PROCS = [
  proc { |fn| fn =~ /(^|[\/\\])core$/ && !File.directory?(fn) }
]
```

### DELEGATING_METHODS = (ARRAY_METHODS + MUST_DEFINE - MUST_NOT_DEFINE).map(&:to_s).sort.uniq

### GLOB_PATTERN = %r{[*?\[\{]}

### MUST_DEFINE = %w[inspect <=>]

List of additional methods that must be delegated.

### MUST_NOT_DEFINE = %w[to_a to_ary partition * <<]

List of methods that should not be delegated here (we define special
versions of them explicitly below).

### SPECIAL_RETURN

```ruby
SPECIAL_RETURN = %w[
  map collect sort sort_by select find_all reject grep
  compact flatten uniq values_at
  + - & |
]
```

List of delegated methods that return new array values which need
wrapping.

## Class methods

### .[](*args)

Create a new file list including the files listed. Similar to:

```
FileList.new(*args)
```

### .glob(pattern, *args)

Get a sorted list of files matching the pattern. This method
should be preferred to Dir[pattern] and Dir.glob(pattern) because
the files returned are guaranteed to be sorted.

## Instance methods

### #*(other)

Redefine * to return either a string or a new file list.

### #<<(obj)

### #==(array)

A FileList is equal through array equality.

### #clear_exclude

Clear all the exclude patterns so that we exclude nothing.

### #egrep(pattern, *options)

Grep each of the files in the filelist using the given pattern. If a
block is given, call the block on each matching line, passing the file
name, line number, and the matching line of text.  If no block is given,
a standard emacs style file:linenumber:line message will be printed to
standard out.  Returns the number of matched items.

### #exclude(*patterns, &block)

Register a list of file name patterns that should be excluded from the
list.  Patterns may be regular expressions, glob patterns or regular
strings.  In addition, a block given to exclude will remove entries that
return true when given to the block.

Note that glob patterns are expanded against the file system. If a file
is explicitly added to a file list, but does not exist in the file
system, then an glob pattern in the exclude list will not exclude the
file.

Examples:
```
FileList['a.c', 'b.c'].exclude("a.c") => ['b.c']
FileList['a.c', 'b.c'].exclude(/^a/)  => ['b.c']
```

If "a.c" is a file, then ...
```
FileList['a.c', 'b.c'].exclude("a.*") => ['b.c']
```

If "a.c" is not a file, then ...
```
FileList['a.c', 'b.c'].exclude("a.*") => ['a.c', 'b.c']
```

### #excluded_from_list?(fn)

Should the given file name be excluded from the list?

NOTE: This method was formerly named "exclude?", but Rails
introduced an exclude? method as an array method and setup a
conflict with file list. We renamed the method to avoid
confusion. If you were using "FileList#exclude?" in your user
code, you will need to update.

Returns: `Boolean`

### #existing

Return a new file list that only contains file names from the current
file list that exist on the file system.

### #existing!

Modify the current file list so that it contains only file name that
exist on the file system.

### #ext(newext = "")

Return a new FileList with `String#ext` method applied to
each member of the array.

This method is a shortcut for:

```
array.collect { |item| item.ext(newext) }
```

`ext` is a user added method for the Array class.

### #gsub(pat, rep)

Return a new FileList with the results of running `gsub` against each
element of the original list.

Example:
```
FileList['lib/test/file', 'x/y'].gsub(/\//, "\\")
   => ['lib\\test\\file', 'x\\y']
```

### #gsub!(pat, rep)

Same as `gsub` except that the original file list is modified.

### #import(array)

### #include(*filenames)

Add file names defined by glob patterns to the file list.  If an array
is given, add each element of the array.

Example:
```
file_list.include("*.java", "*.cfg")
file_list.include %w( math.c lib.h *.o )
```

Also known as: `add`

### #initialize(*patterns) {|_self| ... }

Create a file list from the globbable patterns given.  If you wish to
perform multiple includes or excludes at object build time, use the
"yield self" pattern.

Example:
```
file_list = FileList.new('lib/**/*.rb', 'test/test*.rb')

pkg_files = FileList.new('lib/**/*') do |fl|
  fl.exclude(/\bCVS\b/)
end
```

Yields: `_self`

Yield Parameters:
- `_self` (`Rake::FileList`) — the object that the method was called on

### #is_a?(klass)

Lie about our class.

Returns: `Boolean`

Also known as: `kind_of?`

### #partition(&block)

FileList version of partition.  Needed because the nested arrays should
be FileLists in this version.

### #pathmap(spec = nil, &block)

Apply the pathmap spec to each of the included file names, returning a
new file list with the modified paths.  (See String#pathmap for
details.)

### #resolve

Resolve all the pending adds now.

### #sub(pat, rep)

Return a new FileList with the results of running `sub` against each
element of the original list.

Example:
```
FileList['a.c', 'b.c'].sub(/\.c$/, '.o')  => ['a.o', 'b.o']
```

### #sub!(pat, rep)

Same as `sub` except that the original file list is modified.

### #to_a

Return the internal array object.

### #to_ary

Return the internal array object.

### #to_s

Convert a FileList to a string by joining all elements with a space.
