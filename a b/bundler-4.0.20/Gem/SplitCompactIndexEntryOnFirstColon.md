# module Gem::SplitCompactIndexEntryOnFirstColon
Defined in: `lib/bundler/rubygems_ext.rb`

RubyGems before 4.0.13 split compact index dependency/requirement entries
on every colon, which mangles metadata values that contain colons such as
the `created_at` timestamps the cooldown feature relies on. Split only on
the first colon so those values survive on older RubyGems.

The module is defined unconditionally so it stays testable on any RubyGems,
but only prepended when the host RubyGems still has the buggy behavior.
