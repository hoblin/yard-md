# class Bundler::Thor::Actions::CapturableERB < ERB
Defined in: `lib/bundler/vendor/thor/lib/thor/actions/file_manipulation.rb`

Bundler::Thor::Actions#capture depends on what kind of buffer is used in ERB.
Thus CapturableERB fixes ERB to use String buffer.

## Instance methods

### #set_eoutvar(compiler, eoutvar = "_erbout")
