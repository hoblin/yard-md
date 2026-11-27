# module Rake::TraceOutput
Defined in: `lib/rake/trace_output.rb`

## Instance methods

### #trace_on(out, *strings)

Write trace output to output stream `out`.

The write is done as a single IO call (to print) to lessen the
chance that the trace output is interrupted by other tasks also
producing output.
