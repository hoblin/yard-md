# module FileUtils
Defined in: `lib/rake/file_utils.rb`

--
This a FileUtils extension that defines several additional commands to be
added to the FileUtils utility functions.

## Constants

### LN_SUPPORTED = [true]

### RUBY

```ruby
RUBY = ENV["RUBY"] || File.join(
RbConfig::CONFIG["bindir"],
RbConfig::CONFIG["ruby_install_name"] + RbConfig::CONFIG["EXEEXT"]).
sub(/.*\s.*/m, '"\&"')
```

Path to the currently running Ruby program

## Instance methods

### #ruby(*args, **options, &block)

Run a Ruby interpreter with the given arguments.

Example:
```
ruby %{-pe '$_.upcase!' <README}
```

### #safe_ln(*args, **options)

Attempt to do a normal file link, but fall back to a copy if the link
```
fails.
```

### #sh(*cmd, &block)

Run the system command `cmd`.  If multiple arguments are given the command
is run directly (without the shell, same semantics as Kernel::exec and
Kernel::system).

It is recommended you use the multiple argument form over interpolating
user input for both usability and security reasons.  With the multiple
argument form you can easily process files with spaces or other shell
reserved characters in them.  With the multiple argument form your rake
tasks are not vulnerable to users providing an argument like
`; rm # -rf /`.

If a block is given, upon command completion the block is called with an
OK flag (true on a zero exit status) and a Process::Status object.
Without a block a RuntimeError is raised when the command exits non-zero.

Examples:

```
sh 'ls -ltr'

sh 'ls', 'file with spaces'

# check exit status after command runs
sh %{grep pattern file} do |ok, res|
  if !ok
    puts "pattern not found (status = #{res.exitstatus})"
  end
end
```

### #split_all(path)

Split a file path into individual directory names.

Example:
```
split_all("a/b/c") =>  ['a', 'b', 'c']
```
