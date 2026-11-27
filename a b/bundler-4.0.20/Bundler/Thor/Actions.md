# module Bundler::Thor::Actions
Defined in: `lib/bundler/vendor/thor/lib/thor/actions.rb`

## Constants

### WARNINGS = {unchanged_no_flag: "File unchanged! Either the supplied flag value not found or the content has already been inserted!"}

Injects the given content into a file. Different from gsub_file, this
method is reversible.

###### Parameters
**destination<String>** — Relative path to the destination root
**data<String>** — Data to add to the file. Can be given as a block.
**config<Hash>** — give :verbose => false to not log the status and the flag
               for injection (:after or :before) or :force => true for
               insert two or more times the same content.

###### Examples

```
insert_into_file "config/environment.rb", "config.gem :thor", :after => "Rails::Initializer.run do |config|\n"

insert_into_file "config/environment.rb", :after => "Rails::Initializer.run do |config|\n" do
  gems = ask "Which gems would you like to add?"
  gems.split(" ").map{ |gem| "  config.gem :#{gem}" }.join("\n")
end
```

## Instance attributes

### #behavior

Returns the value of attribute behavior.

## Class methods

### .included(base)

## Instance methods

### #action(instance)

Wraps an action object and call it accordingly to the thor class behavior.

### #append_to_file(path, *args, &block)

Append text to a file. Since it depends on insert_into_file, it's reversible.

###### Parameters
**path<String>** — path of the file to be changed
**data<String>** — the data to append to the file, can be also given as a block.
**config<Hash>** — give :verbose => false to not log the status.

###### Example

```
append_to_file 'config/environments/test.rb', 'config.gem "rspec"'

append_to_file 'config/environments/test.rb' do
  'config.gem "rspec"'
end
```

Also known as: `append_file`

### #apply(path, config = {})

Loads an external file and execute it in the instance binding.

###### Parameters
**path<String>** — The path to the file to execute. Can be a web address or
               a relative path from the source root.

###### Examples

```
apply "http://gist.github.com/103208"

apply "recipes/jquery.rb"
```

### #chmod(path, mode, config = {})

Changes the mode of the given file or directory.

###### Parameters
**mode<Integer>** — the file mode
**path<String>** — the name of the file to change mode
**config<Hash>** — give :verbose => false to not log the status.

###### Example

```
chmod "script/server", 0755
```

### #comment_lines(path, flag, *args)

Comment all lines matching a given regex.  It will leave the space
which existed before the beginning of the line in tact and will insert
a single space after the comment hash.

###### Parameters
**path<String>** — path of the file to be changed
**flag<Regexp|String>** — the regexp or string used to decide which lines to comment
**config<Hash>** — give :verbose => false to not log the status.

###### Example

```
comment_lines 'config/initializers/session_store.rb', /cookie_store/
```

### #copy_file(source, *args, &block)

Copies the file from the relative source to the relative destination. If
the destination is not given it's assumed to be equal to the source.

###### Parameters
**source<String>** — the relative path to the source root.
**destination<String>** — the relative path to the destination root.
**config<Hash>** — give :verbose => false to not log the status, and
               :mode => :preserve, to preserve the file mode from the source.

###### Examples

```
copy_file "README", "doc/README"

copy_file "doc/README"
```

### #create_file(destination, *args, &block)

Create a new file relative to the destination root with the given data,
which is the return value of a block or a data string.

###### Parameters
**destination<String>** — the relative path to the destination root.
**data<String|NilClass>** — the data to append to the file.
**config<Hash>** — give :verbose => false to not log the status.

###### Examples

```
create_file "lib/fun_party.rb" do
  hostname = ask("What is the virtual hostname I should use?")
  "vhost.name = #{hostname}"
end

create_file "config/apache.conf", "your apache config"
```

Also known as: `add_file`

### #create_link(destination, *args)

Create a new file relative to the destination root from the given source.

###### Parameters
**destination<String>** — the relative path to the destination root.
**source<String|NilClass>** — the relative path to the source root.
**config<Hash>** — give :verbose => false to not log the status.
  :: give :symbolic => false for hard link.

###### Examples

```
create_link "config/apache.conf", "/etc/apache.conf"
```

Also known as: `add_link`

### #destination_root

Returns the root for this thor class (also aliased as destination root).

### #destination_root=(root)

Sets the root for this thor class. Relatives path are added to the
directory where the script was invoked and expanded.

### #directory(source, *args, &block)

Copies recursively the files from source directory to root directory.
If any of the files finishes with .tt, it's considered to be a template
and is placed in the destination without the extension .tt. If any
empty directory is found, it's copied and all .empty_directory files are
ignored. If any file name is wrapped within % signs, the text within
the % signs will be executed as a method and replaced with the returned
value. Let's suppose a doc directory with the following files:

```
doc/
  components/.empty_directory
  README
  rdoc.rb.tt
  %app_name%.rb
```

When invoked as:

```
directory "doc"
```

It will create a doc directory in the destination with the following
files (assuming that the `app_name` method returns the value "blog"):

```
doc/
  components/
  README
  rdoc.rb
  blog.rb
```

**Encoded path note:** Since Bundler::Thor internals use Object#respond_to? to check if it can
expand %something%, this `something` should be a public method in the class calling
#directory. If a method is private, Bundler::Thor stack raises PrivateMethodEncodedError.

###### Parameters
**source<String>** — the relative path to the source root.
**destination<String>** — the relative path to the destination root.
**config<Hash>** — give :verbose => false to not log the status.
               If :recursive => false, does not look for paths recursively.
               If :mode => :preserve, preserve the file mode from the source.
               If :exclude_pattern => /regexp/, prevents copying files that match that regexp.

###### Examples

```
directory "doc"
directory "doc", "docs", :recursive => false
```

### #empty_directory(destination, config = {})

Creates an empty directory.

###### Parameters
**destination<String>** — the relative path to the destination root.
**config<Hash>** — give :verbose => false to not log the status.

###### Examples

```
empty_directory "doc"
```

### #find_in_source_paths(file)

Receives a file or directory and search for it in the source paths.

Raises: `Error`

### #get(source, *args, &block)

Gets the content at the given address and places it at the given relative
destination. If a block is given instead of destination, the content of
the url is yielded and used as location.

`get` relies on open-uri, so passing application user input would provide
a command injection attack vector.

###### Parameters
**source<String>** — the address of the given content.
**destination<String>** — the relative path to the destination root.
**config<Hash>** — give :verbose => false to not log the status, and
               :http_headers => <Hash> to add headers to an http request.

###### Examples

```
get "http://gist.github.com/103208", "doc/README"

get "http://gist.github.com/103208", "doc/README", :http_headers => {"Content-Type" => "application/json"}

get "http://gist.github.com/103208" do |content|
  content.split("\n").first
end
```

### #gsub_file(path, flag, *args, &block)

Run a regular expression replacement on a file.

###### Parameters
**path<String>** — path of the file to be changed
**flag<Regexp|String>** — the regexp or string to be replaced
**replacement<String>** — the replacement, can be also given as a block
**config<Hash>** — give :verbose => false to not log the status, and
               :force => true, to force the replacement regardless of runner behavior.

###### Example

```
gsub_file 'app/controllers/application_controller.rb', /#\s*(filter_parameter_logging :password)/, '\1'

gsub_file 'README', /rake/, :green do |match|
  match << " no more. Use thor!"
end
```

### #gsub_file!(path, flag, *args, &block)

Run a regular expression replacement on a file, raising an error if the
contents of the file are not changed.

###### Parameters
**path<String>** — path of the file to be changed
**flag<Regexp|String>** — the regexp or string to be replaced
**replacement<String>** — the replacement, can be also given as a block
**config<Hash>** — give :verbose => false to not log the status, and
               :force => true, to force the replacement regardless of runner behavior.

###### Example

```
gsub_file! 'app/controllers/application_controller.rb', /#\s*(filter_parameter_logging :password)/, '\1'

gsub_file! 'README', /rake/, :green do |match|
  match << " no more. Use thor!"
end
```

### #in_root

Goes to the root and execute the given block.

### #initialize(args = [], options = {}, config = {})

Extends initializer to add more configuration options.

###### Configuration
**behavior<Symbol>** — The actions default behavior. Can be :invoke or :revoke.
                   It also accepts :force, :skip and :pretend to set the behavior
                   and the respective option.

**destination_root<String>** — The root directory needed for some actions.

### #inject_into_class(path, klass, *args, &block)

Injects text right after the class definition. Since it depends on
insert_into_file, it's reversible.

###### Parameters
**path<String>** — path of the file to be changed
**klass<String|Class>** — the class to be manipulated
**data<String>** — the data to append to the class, can be also given as a block.
**config<Hash>** — give :verbose => false to not log the status.

###### Examples

```
inject_into_class "app/controllers/application_controller.rb", "ApplicationController", "  filter_parameter :password\n"

inject_into_class "app/controllers/application_controller.rb", "ApplicationController" do
  "  filter_parameter :password\n"
end
```

### #inject_into_module(path, module_name, *args, &block)

Injects text right after the module definition. Since it depends on
insert_into_file, it's reversible.

###### Parameters
**path<String>** — path of the file to be changed
**module_name<String|Class>** — the module to be manipulated
**data<String>** — the data to append to the class, can be also given as a block.
**config<Hash>** — give :verbose => false to not log the status.

###### Examples

```
inject_into_module "app/helpers/application_helper.rb", "ApplicationHelper", "  def help; 'help'; end\n"

inject_into_module "app/helpers/application_helper.rb", "ApplicationHelper" do
  "  def help; 'help'; end\n"
end
```

### #insert_into_file(destination, *args, &block)

Also known as: `inject_into_file`

### #inside(dir = "", config = {}, &block)

Do something in the root or on a provided subfolder. If a relative path
is given it's referenced from the current root. The full path is yielded
to the block you provide. The path is set back to the previous path when
the method exits.

Returns the value yielded by the block.

###### Parameters
**dir<String>** — the directory to move to.
**config<Hash>** — give :verbose => true to log and use padding.

### #link_file(source, *args)

Links the file from the relative source to the relative destination. If
the destination is not given it's assumed to be equal to the source.

###### Parameters
**source<String>** — the relative path to the source root.
**destination<String>** — the relative path to the destination root.
**config<Hash>** — give :verbose => false to not log the status.

###### Examples

```
link_file "README", "doc/README"

link_file "doc/README"
```

### #prepend_to_file(path, *args, &block)

Prepend text to a file. Since it depends on insert_into_file, it's reversible.

###### Parameters
**path<String>** — path of the file to be changed
**data<String>** — the data to prepend to the file, can be also given as a block.
**config<Hash>** — give :verbose => false to not log the status.

###### Example

```
prepend_to_file 'config/environments/test.rb', 'config.gem "rspec"'

prepend_to_file 'config/environments/test.rb' do
  'config.gem "rspec"'
end
```

Also known as: `prepend_file`

### #relative_to_original_destination_root(path, remove_dot = true)

Returns the given path relative to the absolute root (ie, root where
the script started).

### #remove_file(path, config = {})

Removes a file at the given location.

###### Parameters
**path<String>** — path of the file to be changed
**config<Hash>** — give :verbose => false to not log the status.

###### Example

```
remove_file 'README'
remove_file 'app/controllers/application_controller.rb'
```

Also known as: `remove_dir`

### #run(command, config = {})

Executes a command returning the contents of the command.

###### Parameters
**command<String>** — the command to be executed.
**config<Hash>** — give :verbose => false to not log the status, :capture => true to hide to output. Specify :with
               to append an executable to command execution.

###### Example

```
inside('vendor') do
  run('ln -s ~/edge rails')
end
```

### #run_ruby_script(command, config = {})

Executes a ruby script (taking into account WIN32 platform quirks).

###### Parameters
**command<String>** — the command to be executed.
**config<Hash>** — give :verbose => false to not log the status.

### #source_paths

Holds source paths in instance so they can be manipulated.

### #template(source, *args, &block)

Gets an ERB template at the relative source, executes it and makes a copy
at the relative destination. If the destination is not given it's assumed
to be equal to the source removing .tt from the filename.

###### Parameters
**source<String>** — the relative path to the source root.
**destination<String>** — the relative path to the destination root.
**config<Hash>** — give :verbose => false to not log the status.

###### Examples

```
template "README", "doc/README"

template "doc/README"
```

### #thor(command, *args)

Run a thor command. A hash of options can be given and it's converted to
switches.

###### Parameters
**command<String>** — the command to be invoked
**args<Array>** — arguments to the command
**config<Hash>** — give :verbose => false to not log the status, :capture => true to hide to output.
               Other options are given as parameter to Bundler::Thor.


###### Examples

```
thor :install, "http://gist.github.com/103208"
#=> thor install http://gist.github.com/103208

thor :list, :all => true, :substring => 'rails'
#=> thor list --all --substring=rails
```

### #uncomment_lines(path, flag, *args)

Uncomment all lines matching a given regex. Preserves indentation before
the comment hash and removes the hash and any immediate following space.

###### Parameters
**path<String>** — path of the file to be changed
**flag<Regexp|String>** — the regexp or string used to decide which lines to uncomment
**config<Hash>** — give :verbose => false to not log the status.

###### Example

```
uncomment_lines 'config/initializers/session_store.rb', /active_record/
```
