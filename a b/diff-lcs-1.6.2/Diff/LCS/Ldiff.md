# class Diff::LCS::Ldiff
Defined in: `lib/diff/lcs/ldiff.rb`

## Constants

### BANNER

```ruby
BANNER = <<-COPYRIGHT
ldiff #{Diff::LCS::VERSION}
Copyright 2004-2025 Austin Ziegler

Part of Diff::LCS.
https://github.com/halostatue/diff-lcs

This program is free software. It may be redistributed and/or modified under
the terms of the GPL version 2 (or later), the Perl Artistic licence, or the
MIT licence.
COPYRIGHT
```

standard:disable Layout/HeredocIndentation

## Instance attributes

### #data_new (read-only)

### #data_old (read-only)

### #file_new (read-only)

### #file_old (read-only)

### #format (read-only)

### #lines (read-only)

## Class methods

### .run(args, input = $stdin, output = $stdout, error = $stderr)

## Instance methods

### #diff?(info_old, info_new, format, output, binary: nil, lines: 0)

Returns: `Boolean`

### #initialize

### #run(args, _input = $stdin, output = $stdout, error = $stderr)
