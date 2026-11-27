# module Rake::InvocationExceptionMixin
Defined in: `lib/rake/invocation_exception_mixin.rb`

## Instance methods

### #chain

Return the invocation chain (list of Rake tasks) that were in
effect when this exception was detected by rake.  May be null if
no tasks were active.

### #chain=(value)

Set the invocation chain in effect when this exception was
detected.
