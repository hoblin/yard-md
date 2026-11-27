# class Bundler::RubyGemsGemInstaller < Gem::Installer
Defined in: `lib/bundler/rubygems_gem_installer.rb`

## Constants

### MAX_JOBS_PER_GEM = 3

Cap how many jobserver slots a single gem's `make` may grab so that one
gem with many recipes doesn't starve the others sharing the pool. Beyond
a handful of jobs the extra parallelism rarely pays off in practice.

## Instance methods

### #build_extensions

### #build_jobs

### #check_executable_overwrite(filename)

### #ensure_writable_dir(dir)

### #gem_checksum

### #generate_bin_script(filename, bindir)

### #generate_plugins

### #install

### #pre_install_checks

### #spec
