# class Rake::InvocationChain < Rake::LinkedList
Defined in: `lib/rake/invocation_chain.rb`

InvocationChain tracks the chain of task invocations to detect
circular dependencies.

## Class methods

### .append(invocation, chain)

Class level append.

## Instance methods

### #append(invocation)

Append an invocation to the chain of invocations. It is an error
if the invocation already listed.

### #member?(invocation)

Is the invocation already in the chain?

Returns: `Boolean`

### #to_s

Convert to string, ie: TOP => invocation => invocation
