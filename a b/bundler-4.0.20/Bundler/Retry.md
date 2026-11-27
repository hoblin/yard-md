# class Bundler::Retry
Defined in: `lib/bundler/retry.rb`

General purpose class for retrying code that may fail

## Class attributes

### .default_base_delay

Returns the value of attribute default_base_delay.

## Instance attributes

### #current_run

Returns the value of attribute current_run.

### #name

Returns the value of attribute name.

### #total_runs

Returns the value of attribute total_runs.

## Class methods

### .default_attempts

Also known as: `attempts`

### .default_retries

## Instance methods

### #attempt(&block)

Also known as: `attempts`

### #initialize(name, exceptions = nil, retries = self.class.default_retries, opts = {})
