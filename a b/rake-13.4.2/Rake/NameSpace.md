# class Rake::NameSpace
Defined in: `lib/rake/name_space.rb`

The NameSpace class will lookup task names in the scope defined by a
`namespace` command.

## Instance methods

### #[](name)

Lookup a task named `name` in the namespace.

### #initialize(task_manager, scope_list)

Create a namespace lookup object using the given task manager
and the list of scopes.

### #scope

The scope of the namespace (a LinkedList)

### #tasks

Return the list of tasks defined in this and nested namespaces.
