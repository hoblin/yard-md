# class Rake::EarlyTime
Includes: `Singleton`, `Comparable`
Defined in: `lib/rake/early_time.rb`

EarlyTime is a fake timestamp that occurs *before* any other time value.

## Instance methods

### #<=>(other)

The EarlyTime always comes before `other`!

### #to_s
