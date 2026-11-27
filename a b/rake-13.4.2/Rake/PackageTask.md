# class Rake::PackageTask < Rake::TaskLib
Defined in: `lib/rake/packagetask.rb`

Create a packaging task that will package the project into
distributable files (e.g zip archive or tar files).

The PackageTask will create the following targets:

`:package` ::
```
Create all the requested package files.
```

`:clobber_package` ::
```
Delete all the package files.  This target is automatically
added to the main clobber target.
```

`:repackage` ::
```
Rebuild the package files from scratch, even if they are not out
of date.
```

**`"*package_dir*/*name*-*version*.tgz"` **
  Create a gzipped tar package (if *need_tar* is true).

**`"*package_dir*/*name*-*version*.tar.gz"` **
  Create a gzipped tar package (if *need_tar_gz* is true).

**`"*package_dir*/*name*-*version*.tar.bz2"` **
  Create a bzip2'd tar package (if *need_tar_bz2* is true).

**`"*package_dir*/*name*-*version*.zip"` **
  Create a zip package archive (if *need_zip* is true).

Example:

```
Rake::PackageTask.new("rake", "1.2.3") do |p|
  p.need_tar = true
  p.package_files.include("lib/**/*.rb")
end
```

## Instance attributes

### #name

Name of the package (from the GEM Spec).

### #need_tar

True if a gzipped tar file (tgz) should be produced (default is
false).

### #need_tar_bz2

True if a bzip2'd tar file (tar.bz2) should be produced (default
is false).

### #need_tar_gz

True if a gzipped tar file (tar.gz) should be produced (default
is false).

### #need_tar_xz

True if a xz'd tar file (tar.xz) should be produced (default is false)

### #need_zip

True if a zip file should be produced (default is false)

### #package_dir

Directory used to store the package files (default is 'pkg').

### #package_files

List of files to be included in the package.

### #tar_command

Tar command for gzipped or bzip2ed archives.  The default is 'tar'.

### #version

Version of the package (e.g. '1.3.2').

### #without_parent_dir

True if parent directory should be omitted (default is false)

### #zip_command

Zip command for zipped archives.  The default is 'zip'.

## Instance methods

### #define

Create the tasks defined by this task library.

### #init(name, version)

Initialization that bypasses the "yield self" and "define" step.

### #initialize(name = nil, version = nil) {|_self| ... }

Create a Package Task with the given name and version.  Use `:noversion`
as the version to build a package without a version or to provide a
fully-versioned package name.

Yields: `_self`

Yield Parameters:
- `_self` (`Rake::PackageTask`) — the object that the method was called on

### #package_dir_path

The directory this package will be built in

### #package_name

The name of this package

### #tar_bz2_file

The package name with .tar.bz2 added

### #tar_gz_file

The package name with .tar.gz added

### #tar_xz_file

The package name with .tar.xz added

### #target_dir

target directory relative to working_dir

### #tgz_file

The package name with .tgz added

### #working_dir

### #zip_file

The package name with .zip added
