# class Rake::Scope < Rake::LinkedList
Defined in: `lib/rake/scope.rb`

## Constants

### EMPTY = EmptyScope.new

Singleton null object for an empty scope.

## Instance methods

### #path

Path for the scope.

### #path_with_task_name(task_name)

Path for the scope + the named path.

### #trim(n)

Trim `n` innermost scope levels from the scope. In no case will
this trim beyond the toplevel scope.
