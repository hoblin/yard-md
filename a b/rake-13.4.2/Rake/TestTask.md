# class Rake::TestTask < Rake::TaskLib
Defined in: `lib/rake/testtask.rb`

Create a task that runs a set of tests.

Example:
```
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end
```

If rake is invoked with a "TEST=filename" command line option,
then the list of test files will be overridden to include only the
filename specified on the command line.  This provides an easy way
to run just one test.

If rake is invoked with a "TESTOPTS=options" command line option,
then the given options are passed to the test process after a
'--'.  This allows Test::Unit options to be passed to the test
suite.

Examples:

```
rake test                           # run tests normally
rake test TEST=just_one_file.rb     # run just one test file.
rake test TESTOPTS="-v"             # run in verbose mode
rake test TESTOPTS="--runner=fox"   # use the fox test runner
```

## Instance attributes

### #deps

Task prerequisites.

### #description

Description of the test task. (default is 'Run tests')

### #libs

List of directories added to $LOAD_PATH before running the
tests. (default is 'lib')

### #loader

Style of test loader to use.  Options are:

* :rake -- Rake provided test loading script (default).
* :testrb -- Ruby provided test loading script.
* :direct -- Load tests using command line loader.

### #name

Name of test task. (default is :test)

### #options

Test options passed to the test suite.  An explicit
TESTOPTS=opts on the command line will override this. (default
is NONE)

### #pattern

Glob pattern to match test files. (default is 'test/test*.rb')

### #ruby_opts

Array of command line options to pass to ruby when running test loader.

### #verbose

True if verbose test output desired. (default is false)

### #warning

Request that the tests be run with the warning flag set.
E.g. warning=true implies "ruby -w" used to run the tests.
(default is true)

## Instance methods

### #define

Create the tasks defined by this task lib.

### #file_list

### #file_list_string

### #initialize(name = :test) {|_self| ... }

Create a testing task.

Yields: `_self`

Yield Parameters:
- `_self` (`Rake::TestTask`) — the object that the method was called on

### #lib_path

### #option_list(verbose: @verbose)

### #ruby_opts_string

### #ruby_version

### #run_code

### #test_files=(list)

Explicitly define the list of test files to be included in a
test.  `list` is expected to be an array of file names (a
FileList is acceptable).  If both `pattern` and `test_files` are
used, then the list of test files is the union of the two.
