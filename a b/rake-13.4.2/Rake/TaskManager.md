# module Rake::TaskManager
Defined in: `lib/rake/task_manager.rb`

The TaskManager module is a mixin for managing tasks.

## Class attributes

### .record_task_metadata

## Instance attributes

### #last_description

Track the last comment made in the Rakefile.

## Instance methods

### #[](task_name, scopes = nil)

Find a matching task for `task_name`.

### #clear

Clear all tasks in this application.

### #create_rule(*args, &block)

### #current_scope

Return the list of scope names currently active in the task
manager.

### #define_task(task_class, *args, &block)

### #enhance_with_matching_rule(task_name, level = 0)

If a rule can be found that matches the task name, enhance the
task with the prerequisites and actions from the rule.  Set the
source attribute of the task appropriately for the rule.  Return
the enhanced task or nil of no rule was found.

### #generate_did_you_mean_suggestions(task_name)

### #generate_message_for_undefined_task(task_name)

### #in_namespace(name)

Evaluate the block in a nested namespace named `name`.  Create
an anonymous namespace if `name` is nil.

### #initialize

### #intern(task_class, task_name)

Lookup a task.  Return an existing task if found, otherwise
create a task of the current type.

### #lookup(task_name, initial_scope = nil)

Lookup a task, using scope and the scope hints in the task name.
This method performs straight lookups without trying to
synthesize file tasks or rules.  Special scope names (e.g. '^')
are recognized.  If no scope argument is supplied, use the
current scope.  Return nil if the task cannot be found.

### #resolve_args(args)

Resolve the arguments for a task/rule.  Returns a tuple of
[task_name, arg_name_list, prerequisites, order_only_prerequisites].

### #synthesize_file_task(task_name)

### #tasks

List of all defined tasks in this application.

### #tasks_in_scope(scope)

List of all the tasks defined in the given scope (and its
sub-scopes).
