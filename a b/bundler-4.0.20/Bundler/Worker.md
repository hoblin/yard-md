# class Bundler::Worker
Defined in: `lib/bundler/worker.rb`

## Constants

### POISON = Object.new

## Instance attributes

### #name (read-only)

Returns: `String` — the name of the worker

## Instance methods

### #deq

Retrieves results of job function being executed in worker pool

### #enq(obj, priority: false)

Enqueue a request to be executed in the worker pool

Parameters:
- `obj` (`String`) — mostly it is name of spec that should be downloaded

### #initialize(size, name, func)

Creates a worker pool of specified size

Parameters:
- `size` (`Integer`) — Size of pool
- `name` (`String`) — name the name of the worker
- `func` (`Proc`) — job to run in inside the worker pool

### #stop
