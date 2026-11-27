# module Rake
Extended by: `Rake::FileUtilsExt`
Defined in: `lib/rake.rb`

## Constants

### CommandLineOptionError = Class.new(StandardError)

### EARLY = EarlyTime.instance

### EMPTY_TASK_ARGS = TaskArguments.new([], [])

### LATE = LateTime.instance

### VERSION = "13.4.2"

## Class methods

### .add_rakelib(*files)

Add files to the rakelib list

### .application

Current Rake Application

### .application=(app)

Set the current Rake application object.

### .each_dir_parent(dir)

Yield each file or directory component.

### .from_pathname(path)

Convert Pathname and Pathname-like objects to strings;
leave everything else alone

### .load_rakefile(path)

Load a rakefile.

### .original_dir

Return the original directory where the Rake application was started.

### .suggested_thread_count

### .with_application(block_application = Rake::Application.new)

Make `block_application` the default rake application inside a block so
you can load rakefiles into a different application.

This is useful when you want to run rake tasks inside a library without
running rake in a sub-shell.

Example:

```
Dir.chdir 'other/directory'

other_rake = Rake.with_application do |rake|
  rake.load_rakefile
end

puts other_rake.tasks
```
