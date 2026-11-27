# class Rake::Task
Defined in: `lib/rake/task.rb`

A Task is the basic unit of work in a Rakefile.  Tasks have associated
actions (possibly more than one) and a list of prerequisites.  When
invoked, a task will first ensure that all of its prerequisites have an
opportunity to run and then it will execute its own actions.

Tasks are not usually created directly using the new method, but rather
use the `file` and `task` convenience methods.

## Instance attributes

### #actions (read-only)

List of actions attached to a task.

### #already_invoked (read-only)

Has this task already been invoked?  Already invoked tasks
will be skipped unless you reenable them.

### #application

Application owning this task.

### #locations (read-only)

File/Line locations of each of the task definitions for this
task (only valid if the task was defined with the detect
location option set).

### #order_only_prerequisites (read-only)

List of order only prerequisites for a task.

### #prerequisites (read-only)

List of prerequisites for a task.

Also known as: `prereqs`

### #scope (read-only)

Array of nested namespaces names used for task lookup by this task.

### #sources

## Class methods

### .[](task_name)

Return a task with the given name.  If the task is not currently
known, try to synthesize one from the defined rules.  If no rules are
found, but an existing file matches the task name, assume it is a file
task with no dependencies or actions.

### .clear

Clear the task list.  This cause rake to immediately forget all the
tasks that have been assigned.  (Normally used in the unit tests.)

### .create_rule(*args, &block)

Define a rule for synthesizing tasks.

### .define_task(*args, &block)

Define a task given `args` and an option block.  If a rule with the
given name already exists, the prerequisites and actions are added to
the existing task.  Returns the defined task.

### .format_deps(deps)

Format dependencies parameter to pass to task.

### .scope_name(scope, task_name)

Apply the scope to the task name according to the rules for
this kind of task.  Generic tasks will accept the scope as
part of the name.

### .task_defined?(task_name)

TRUE if the task name is already defined.

Returns: `Boolean`

### .tasks

List of all defined tasks.

## Instance methods

### #add_description(description)

Add a description to the task.  The description can consist of an option
argument list (enclosed brackets) and an optional comment.

### #all_prerequisite_tasks

List of all unique prerequisite tasks including prerequisite tasks'
prerequisites.
Includes self when cyclic dependencies are found.

### #arg_description

Argument description (nil if none).

### #arg_names

Name of arguments for this task.

### #clear

Clear the existing prerequisites, actions, comments, and arguments of a rake task.

### #clear_actions

Clear the existing actions on a rake task.

### #clear_args

Clear the existing arguments on a rake task.

### #clear_comments

Clear the existing comments on a rake task.

### #clear_prerequisites

Clear the existing prerequisites of a rake task.

### #comment

First line (or sentence) of all comments. Multiple comments are
separated by a "/".

### #comment=(comment)

### #enhance(deps = nil, &block)

Enhance a task with prerequisites or actions.  Returns self.

### #execute(args = nil)

Execute the actions associated with this task.

### #full_comment

Full collection of comments. Multiple comments are separated by
newlines.

### #initialize(task_name, app)

Create a task named `task_name` with no actions or prerequisites. Use
`enhance` to add actions and prerequisites.

### #inspect

### #investigation

Return a string describing the internal state of a task.  Useful for
debugging.

### #invoke(*args)

Invoke the task if it is needed.  Prerequisites are invoked first.

### #invoke_prerequisites(task_args, invocation_chain)

Invoke all the prerequisites of a task.

### #invoke_prerequisites_concurrently(task_args, invocation_chain)

Invoke all the prerequisites of a task in parallel.

### #name

Name of the task, including any namespace qualifiers.

### #name_with_args

Name of task with argument list description.

### #needed?

Is this task needed?

Returns: `Boolean`

### #prerequisite_tasks

List of prerequisite tasks

### #reenable

Reenable the task, allowing its tasks to be executed if the task
is invoked again.

### #set_arg_names(args)

Set the names of the arguments for this task. `args` should be
an array of symbols, one for each argument name.

### #source

First source from a rule (nil if no sources)

### #timestamp

Timestamp for this task.  Basic tasks return the current time for their
time stamp.  Other tasks can be more sophisticated.

### #to_s

Return task name

### #|(deps)

Add order only dependencies.
