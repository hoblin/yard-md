# class Module
Defined in: `lib/rake/ext/core.rb`

## Instance methods

### #rake_extension(method)

Check for an existing method in the current class before extending.  If
the method already exists, then a warning is printed and the extension is
not added.  Otherwise the block is yielded and any definitions in the
block will take effect.

Usage:

```
class String
  rake_extension("xyz") do
    def xyz
      ...
    end
  end
end
```
