# class Rake::FileTask < Rake::Task
Defined in: `lib/rake/file_task.rb`

A FileTask is a task that includes time based dependencies.  If any of a
FileTask's prerequisites have a timestamp that is later than the file
represented by this task, then the file must be rebuilt (using the
supplied actions).

## Class methods

### .scope_name(scope, task_name)

Apply the scope to the task name according to the rules for this kind
of task.  File based tasks ignore the scope when creating the name.

## Instance methods

### #needed?

Is this file task needed?  Yes if it doesn't exist, or if its time stamp
is out of date.

Returns: `Boolean`

### #timestamp

Time stamp for file task.
