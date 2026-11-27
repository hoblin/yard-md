# frozen_string_literal: true

module Sample
  # A gadget another gem adds to Sample.
  class Gadget
  end

  # A widget another gem adds to.
  class Widget
    # The sizes a widget comes in.
    SIZES = %i[small large].freeze

    # Paints every widget.
    def self.paint
    end

    # Paints the widget again.
    def paint
    end

    # Polishes the widget.
    def polish
    end
  end
end

class String
  # Squeezes the string's whitespace.
  def squish
  end
end

# Tidies everything up.
def tidy
end
