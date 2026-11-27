# class Rake::Application
Includes: `Rake::TraceOutput`, `Rake::TaskManager`
Defined in: `lib/rake/application.rb`

Rake main application object.  When invoking `rake` from the
command line, a Rake::Application object is created and run.

## Constants

### DEFAULT_RAKEFILES

```ruby
DEFAULT_RAKEFILES = [
  "rakefile",
  "Rakefile",
  "rakefile.rb",
  "Rakefile.rb"
].freeze
```

## Instance attributes

### #name (read-only)

The name of the application (typically 'rake')

### #original_dir (read-only)

The original directory where rake was invoked.

### #rakefile (read-only)

Name of the actual rakefile used.

### #terminal_columns

Number of columns on the terminal

### #top_level_tasks (read-only)

List of the top level task names (task names from the command line).

### #tty_output (write-only)

Override the detected TTY output state (mostly for testing)

## Instance methods

### #add_import(fn)

Add a file to the list of files to be imported.

### #add_loader(ext, loader)

Add a loader to handle imported files ending in the extension
`ext`.

### #collect_command_line_tasks(args)

Collect the list of tasks on the command line.  If no tasks are
given, return a list containing only the default task.
Environmental assignments are processed at this time as well.

`args` is the list of arguments to peruse to get the list of tasks.
It should be the command line that was given to rake, less any
recognised command-line options, which OptionParser.parse will
have taken care of already.

### #default_task_name

Default task name ("default").
(May be overridden by subclasses)

### #deprecate(old_usage, new_usage, call_site)

Warn about deprecated usage.

Example:
```
Rake.application.deprecate("import", "Rake.import", caller.first)
```

### #display_cause_details(ex)

### #display_error_message(ex)

Display the error message that caused the exception.

### #display_exception_backtrace(ex)

### #display_exception_details(ex)

### #display_exception_details_seen

### #display_exception_message_details(ex)

### #display_prerequisites

Display the tasks and prerequisites

### #display_tasks_and_comments

Display the tasks and comments.

### #dynamic_width

Calculate the dynamic width of the

### #dynamic_width_stty

### #dynamic_width_tput

### #exit_because_of_exception(ex)

Exit the program because of an unhandled exception.
(may be overridden by subclasses)

### #find_rakefile_location

### #handle_options(argv)

Read and handle the command line options.  Returns the command line
arguments that we didn't understand, which should (in theory) be just
task names and env vars.

### #has_cause?(ex)

Returns: `Boolean`

### #have_rakefile

True if one of the files in RAKEFILES is in the current directory.
If a match is found, it is copied into @rakefile.

### #init(app_name = "rake", argv = ARGV)

Initialize the command line parameters and app name.

### #initialize

Initialize a Rake::Application object.

### #invoke_task(task_string)

Invokes a task with arguments that are extracted from `task_string`

### #load_imports

Load the pending list of imported files.

### #load_rakefile

Find the rakefile and then load it and any pending imports.

### #options

Application options from the command line

### #parse_task_string(string)

### #print_rakefile_directory(location)

### #rake_require(file_name, paths = $LOAD_PATH, loaded = $LOADED_FEATURES)

Similar to the regular Ruby `require` command, but will check
for *.rake files in addition to *.rb files.

### #rakefile_location(backtrace = caller)

### #raw_load_rakefile

### #run(argv = ARGV)

Run the Rake application.  The run method performs the following
three steps:

* Initialize the command line options (`init`).
* Define the tasks (`load_rakefile`).
* Run the top level tasks (`top_level`).

If you wish to build a custom rake command, you should call
`init` on your application.  Then define any tasks.  Finally,
call `top_level` to run your top level tasks.

### #run_with_threads

Run the given block with the thread startup and shutdown.

### #set_default_options

### #standard_exception_handling

Provide standard exception handling for the given block.

### #standard_rake_options

A list of all the standard options used in rake, suitable for
passing to OptionParser.

### #system_dir

The directory path containing the system wide rakefiles.

### #terminal_width

### #thread_pool

Return the thread pool used for multithreaded processing.

### #top_level

Run the top level tasks of a Rake application.

### #trace(*strings)

### #truncate(string, width)

### #truncate_output?

We will truncate output if we are outputting to a TTY or if we've been
given an explicit column width to honor

Returns: `Boolean`

### #tty_output?

True if we are outputting to TTY, false otherwise

Returns: `Boolean`

### #unix?

Returns: `Boolean`

### #windows?

Returns: `Boolean`
