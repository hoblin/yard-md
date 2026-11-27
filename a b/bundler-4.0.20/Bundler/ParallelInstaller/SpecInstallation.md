# class Bundler::ParallelInstaller::SpecInstallation
Defined in: `lib/bundler/installer/parallel_installer.rb`

## Instance attributes

### #dependencies

Returns the value of attribute dependencies.

### #error

Returns the value of attribute error.

### #full_name

Returns the value of attribute full_name.

### #name

Returns the value of attribute name.

### #post_install_message

Returns the value of attribute post_install_message.

### #spec

Returns the value of attribute spec.

### #state

Returns the value of attribute state.

## Instance methods

### #dependencies_installed?(installed_specs)

Recursively checks that all dependencies (direct and transitive) have been installed.

Returns: `Boolean`

### #enqueue_with_priority?

Returns: `Boolean`

### #enqueued?

Returns: `Boolean`

### #failed?

Returns: `Boolean`

### #has_post_install_message?

Returns: `Boolean`

### #initialize(spec)

### #installed?

Returns: `Boolean`

### #ready_to_enqueue?

Returns: `Boolean`

### #ready_to_install?(installed_specs)

Returns: `Boolean`

### #to_s
