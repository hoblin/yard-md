# class Bundler::Thor::UndefinedCommandError < Bundler::Thor::Error
Includes: `Bundler::Thor::UndefinedCommandError.if defined?(DidYouMean::SpellChecker) && defined?(DidYouMean::Correctable) # rubocop:disable Naming/ConstantName
  Moduleif defined?(DidYouMean::SpellChecker) && defined?(DidYouMean::Correctable) # rubocop:disable Naming/ConstantName
  Module.new do
    def to_s
      super + DidYouMean.formatter.message_for(corrections)
    end

    def corrections
      @corrections ||= self.class.const_get(:SpellChecker).new(self).corrections
    end
  end
end`
Defined in: `lib/bundler/vendor/thor/lib/thor/error.rb`

Raised when a command was not found.

## Instance attributes

### #all_commands (read-only)

Returns the value of attribute all_commands.

### #command (read-only)

Returns the value of attribute command.

## Instance methods

### #initialize(command, all_commands, namespace)
