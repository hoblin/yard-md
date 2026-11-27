# frozen_string_literal: true

require_relative "sample/notes"

# = Sample
#
# A gem documented in RDoc markup: +code+, <tt>teletype</tt>, *bold* and _emphasis_.
#
# == Usage
#
# Build a widget:
#
#   widget = Sample::Widget.new(:blue)
#   widget.paint(+1+, *args)
#   Sample.where(name: {first: 1}).each {|x| "<b>#{x}</b>" }
#
# [color] the widget's color
# size:: the widget's size
#
# Set with <tt>SET client_encoding TO
# <encoding></tt>. See {file:README.md the readme}, \{literal} and {Sample::Widget}.
module Sample
  VERSION = "0.1.0"

  LIMITS = {
    min: 1,
    max: 10
  }.freeze

  module Empty
    # A class nested in a namespace that documents nothing itself.
    class Inner
    end
  end

  # A widget with a {Sample::Widget#color color}.
  class Widget < Struct
    include Comparable
    extend Enumerable

    # @return [Symbol] the widget's color
    attr_accessor :color
    alias_method :hue, :color

    # The widget's size.
    attr_reader :size

    # Sets the finish.
    attr_writer :finish

    # Creates a widget.
    #
    # @param color [Symbol] the color
    def initialize(color)
      @color = color
    end

    # Paints the widget.
    #
    # :call-seq:
    #   paint(color) -> self
    #
    # Same as [repainting](rdoc-ref:Sample::Widget#repaint) or +hue+[rdoc-ref:Sample::Widget#hue].
    #
    # @param color [Symbol] the new color
    # @param options [Hash] painting options
    # @option options [Boolean] :glossy (false) whether to add gloss
    # @yieldparam previous [Symbol] the color before painting
    # @return [self]
    # @raise [ArgumentError] when the color is unknown
    # @example Paint it +red+
    #
    #   widget.paint(:red) { |previous| puts previous }
    # @see Sample::Widget#color
    # @see https://example.com/paint Painting guide
    def paint(color, options = {})
      self
    end
    alias_method :repaint, :paint
    alias_method :daub, :paint
    private :daub

    # @overload resize(size)
    #   Sets the size.
    #   @param size [Integer] the size
    # @overload resize(width, height)
    #   Sets width and height.
    def resize(*args)
    end

    # Finds a widget by color.
    # @deprecated Use {.where} instead.
    def self.find(color)
    end

    # Forgets the widget.
    # @return [void]
    def forget
    end

    # @api private
    def internal
    end

    # Hidden from the public API.
    # @private
    def hidden
    end

    protected

    def compare
    end

    private

    def secret
    end
  end

  # @api private
  class Internal
    # An internal method.
    def work
    end
  end
end
