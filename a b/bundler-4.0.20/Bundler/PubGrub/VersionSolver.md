# class Bundler::PubGrub::VersionSolver
Defined in: `lib/bundler/vendor/pub_grub/lib/pub_grub/version_solver.rb`

## Instance attributes

### #logger (read-only)

Returns the value of attribute logger.

### #solution (read-only)

Returns the value of attribute solution.

### #source (read-only)

Returns the value of attribute source.

### #strategy (read-only)

Returns the value of attribute strategy.

## Instance methods

### #initialize(source:, root: Package.root, strategy: Strategy.new(source), logger: Bundler::PubGrub.logger)

### #solve

Also known as: `result`

### #solved?

Returns: `Boolean`

### #work

Returns true if there is more work to be done, false otherwise
