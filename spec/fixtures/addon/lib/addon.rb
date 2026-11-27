# frozen_string_literal: true

module Sample
  # A gadget another gem adds to Sample.
  class Gadget
  end

  # A widget another gem adds to.
  class Widget
    # The sizes a widget comes in.
    SIZES = %i[small large].freeze

    FINISHES = %w[matte satin eggshell semi-gloss gloss high-gloss lacquer enamel varnish].freeze

    @@polished = 0

    # @overload scrub(force)
    #   Scrubs the widget, +force+ or not.
    def scrub(*args)
    end

    # Buffs the widget with a {Sample::Widget#color matching} cloth
    # until it shines. Then it rests.
    def buff
    end

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

# Whether the addon is loaded.
ADDON_LOADED = true

# Tidies everything up.
def tidy
end
