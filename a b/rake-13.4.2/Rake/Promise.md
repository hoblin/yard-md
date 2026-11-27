# class Rake::Promise
Defined in: `lib/rake/promise.rb`

A Promise object represents a promise to do work (a chore) in the
future. The promise is created with a block and a list of
arguments for the block. Calling value will return the value of
the promised chore.

Used by ThreadPool.

## Constants

### NOT_SET = Object.new.freeze

## Instance attributes

### #recorder

## Instance methods

### #initialize(args, &block)

Create a promise to do the chore specified by the block.

### #value

Return the value of this promise.

If the promised chore is not yet complete, then do the work
synchronously. We will wait.

### #work

If no one else is working this promise, go ahead and do the chore.
