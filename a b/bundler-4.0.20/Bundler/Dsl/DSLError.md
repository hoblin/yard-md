# class Bundler::Dsl::DSLError < Bundler::GemfileError
Defined in: `lib/bundler/dsl.rb`

## Instance attributes

### #backtrace (read-only)

Returns: `Exception` — the backtrace of the exception raised by the
  evaluation of the dsl file.

### #description (read-only)

Returns: `String` — the description that should be presented to the user.

### #dsl_path (read-only)

Returns: `String` — the path of the dsl file that raised the exception.

## Instance methods

### #contents

Returns: `String` — the contents of the DSL that cause the exception to
  be raised.

### #initialize(description, dsl_path, backtrace, contents = nil)

Parameters:
- `backtrace` (`Exception`) — @see backtrace
- `dsl_path` (`String`) — @see dsl_path

### #status_code

### #to_s

The message of the exception reports the content of podspec for the
line that generated the original exception.

Example: Output

```ruby
Invalid podspec at `RestKit.podspec` - undefined method
`exclude_header_search_paths=' for #<Pod::Specification for
`RestKit/Network (0.9.3)`>

    from spec-repos/master/RestKit/0.9.3/RestKit.podspec:36
    -------------------------------------------
        # because it would break: #import <CoreData/CoreData.h>
 >      ns.exclude_header_search_paths = 'Code/RestKit.h'
      end
    -------------------------------------------
```

Returns: `String` — the message of the exception.
