# class Gem::Platform
Defined in: `lib/bundler/rubygems_ext.rb`

## Constants

### JAVA = Gem::Platform.new("java")

### MINGW = Gem::Platform.new("x86-mingw32")

### MSWIN = Gem::Platform.new("mswin32")

### MSWIN64 = Gem::Platform.new("mswin64")

### UNIVERSAL_MINGW = Gem::Platform.new("universal-mingw")

### WINDOWS = [MSWIN, MSWIN64, UNIVERSAL_MINGW].freeze

### X64_LINUX = Gem::Platform.new("x86_64-linux")

### X64_LINUX_MUSL = Gem::Platform.new("x86_64-linux-musl")

### X64_MINGW = Gem::Platform.new("x64-mingw-ucrt")

### X64_MINGW_LEGACY = Gem::Platform.new("x64-mingw32")

## Class methods

### .generic(platform)

Returns the generic platform for the given platform.

### .platform_specificity_match(spec_platform, user_platform)

Returns the platform specificity match for the given spec platform and user platform.

### .sort_and_filter_best_platform_match(matching, platform)

Sorts and filters the best platform match for the given matching specs and platform.

### .sort_best_platform_match(matching, platform)

Sorts the best platform match for the given matching specs and platform.
