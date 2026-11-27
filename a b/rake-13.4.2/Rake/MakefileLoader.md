# class Rake::MakefileLoader
Includes: `Rake::DSL`
Defined in: `lib/rake/loaders/makefile.rb`

Makefile loader to be used with the import file loader.  Use this to
import dependencies from make dependency tools:

```
require 'rake/loaders/makefile'

file ".depends.mf" => [SRC_LIST] do |t|
  sh "makedepend -f- -- #{CFLAGS} -- #{t.prerequisites} > #{t.name}"
end

import ".depends.mf"
```

See Dependencies[link:doc/rakefile_rdoc.html#label-Importing+Dependencies]
for further details.

## Constants

### SPACE_MARK = "\0"

## Instance methods

### #load(fn)

Load the makefile dependencies in `fn`.
