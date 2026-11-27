# class Rake::FileCreationTask < Rake::FileTask
Defined in: `lib/rake/file_creation_task.rb`

A FileCreationTask is a file task that when used as a dependency will be
needed if and only if the file has not been created.  Once created, it is
not re-triggered if any of its dependencies are newer, nor does trigger
any rebuilds of tasks that depend on it whenever it is updated.

## Instance methods

### #needed?

Is this file task needed?  Yes if it doesn't exist.

Returns: `Boolean`

### #timestamp

Time stamp for file creation task.  This time stamp is earlier
than any other time stamp.
