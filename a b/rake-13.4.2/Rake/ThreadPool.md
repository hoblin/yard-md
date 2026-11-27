# class Rake::ThreadPool
Defined in: `lib/rake/thread_pool.rb`

## Instance methods

### #future(*args, &block)

Creates a future executed by the `ThreadPool`.

The args are passed to the block when executing (similarly to
Thread#new) The return value is an object representing
a future which has been created and added to the queue in the
pool. Sending #value to the object will sleep the
current thread until the future is finished and will return the
result (or raise an exception thrown from the future)

### #gather_history

Enable the gathering of history events.

### #history

Return a array of history events for the thread pool.

History gathering must be enabled to be able to see the events
(see #gather_history). Best to call this when the job is
complete (i.e. after ThreadPool#join is called).

### #initialize(thread_count)

Creates a ThreadPool object.  The `thread_count` parameter is the size
of the pool.

### #join

Waits until the queue of futures is empty and all threads have exited.

### #statistics

Return a hash of always collected statistics for the thread pool.
