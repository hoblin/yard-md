# class Bundler::Thor::UnknownArgumentError < Bundler::Thor::Error
Includes: `Bundler::Thor::UnknownArgumentError.if defined?(DidYouMean::SpellChecker) && defined?(DidYouMean::Correctable) # rubocop:disable Naming/ConstantName
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

## Instance attributes

### #switches (read-only)

Returns the value of attribute switches.

### #unknown (read-only)

Returns the value of attribute unknown.

## Instance methods

### #initialize(switches, unknown)
