# module Bundler::Thor::Actions::ClassMethods
Defined in: `lib/bundler/vendor/thor/lib/thor/actions.rb`

## Instance methods

### #add_runtime_options!

Add runtime options that help actions execution.

### #source_paths

Hold source paths for one Bundler::Thor instance. source_paths_for_search is the
method responsible to gather source_paths from this current class,
inherited paths and the source root.

### #source_paths_for_search

Returns the source paths in the following order:

```
1) This class source paths
2) Source root
3) Parents source paths
```

### #source_root(path = nil)

Stores and return the source root for this class
