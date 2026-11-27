# module Bundler::Thor::Invocation::ClassMethods
Defined in: `lib/bundler/vendor/thor/lib/thor/invocation.rb`

## Instance methods

### #prepare_for_invocation(key, name)

This method is responsible for receiving a name and find the proper
class and command for it. The key is an optional parameter which is
available only in class methods invocations (i.e. in Bundler::Thor::Group).
