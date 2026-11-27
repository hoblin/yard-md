# frozen_string_literal: true

module YardMd
  # @api private
  class Page
    include YARD::Templates::Helpers::BaseHelper
    include YARD::Templates::Helpers::MethodHelper

    SCOPES = {class: ".", instance: "#"}.freeze
    SEPARATOR = "\n\n"
    INLINE = 80
    CALL_SEQ = /\A\s*:call-seq:.*?(?:\n[ \t]*\n|\z)/m

    Entry = Data.define(:text, :group, :names, :detail) do
      def initialize(text:, group: nil, names: [], detail: {})
        super
      end
    end

    def initialize(object, verifier, prose)
      @object = object
      @verifier = verifier
      @prose = prose
    end

    def to_s
      entries.map(&:text).join(SEPARATOR) + "\n" unless entries.empty?
    end

    def members
      first = 1
      entries.each_with_object({constants: {}, methods: {}}) do |entry, members|
        last = first + entry.text.count("\n")
        members[:docs] = {lines: [first, last]} if entry.group == :docs
        entry.names.each { |name| members[entry.group][name] = {lines: [first, last], **entry.detail} }
        first = last + SEPARATOR.count("\n")
      end
    end

    private

    def entries
      @entries ||= begin
        docs = docs(@object, 1)
        body = [
          *(Entry.new(text: docs, group: :docs) unless docs.empty?),
          *constants,
          *SCOPES.keys.flat_map { |scope| attributes(scope) },
          *SCOPES.keys.flat_map { |scope| methods(scope) }
        ]
        body.empty? ? [] : [Entry.new(text: header), *body]
      end
    end

    def header
      title = @object.root? ? "# Top-level namespace" : "# #{@object.type} #{@object.path}"
      title += " < #{@object.superclass.path}" if @object.is_a?(YARD::CodeObjects::ClassObject) && @object.superclass && @object.superclass.path != "Object"
      [
        title,
        list("Includes", @object.mixins(:instance)),
        list("Extended by", @object.mixins(:class)),
        list("Defined in", [@object.file].compact)
      ].compact.join("\n")
    end

    def list(label, items)
      "#{label}: #{items.map { |item| "`#{item}`" }.join(", ")}" if items.any?
    end

    def constants
      constants = @verifier.run(@object.constants(included: false, inherited: false) + @object.cvars)
      section("Constants", constants.sort_by(&:name).map { |constant| constant_entry(constant) })
    end

    def constant_entry(constant)
      value = constant.value.to_s
      heading = value.include?("\n") ? "### #{constant.name}\n\n```ruby\n#{constant.name} = #{value}\n```" : "### #{constant.name} = #{value}"
      Entry.new(
        text: [heading, docs(constant, 3)].reject(&:empty?).join(SEPARATOR),
        group: :constants,
        names: (constant.type == :constant) ? [constant.name.to_s] : [],
        detail: shown(value)
      )
    end

    def shown(value)
      lines = value.lines.size
      if lines > 1 then {size: "#{lines} lines"}
      elsif value.size > INLINE then {size: "#{value.size} characters"}
      else {value: value}
      end
    end

    def attributes(scope)
      entries = @object.attributes[scope].sort_by(&:first).filter_map do |name, accessors|
        reader, writer = accessors.values_at(:read, :write).map { |accessor| @verifier.run([accessor].compact).first }
        next unless reader || writer

        access = if reader && writer then ""
        elsif reader then " (read-only)"
        else " (write-only)"
        end
        named_entry([reader, writer].compact, ["### #{SCOPES[scope]}#{name}#{access}", docs(reader || writer, 3)])
      end
      section("#{scope.capitalize} attributes", entries)
    end

    def methods(scope)
      methods = @verifier.run(@object.meths(inherited: false, included: false, scope: scope))
        .reject { |method| method.is_alias? || method.is_attribute? }
        .sort_by { |method| method.name.to_s.downcase }
      section("#{scope.capitalize} methods", methods.map { |method| method_entry(method) })
    end

    def method_entry(method)
      heading = "### #{SCOPES[method.scope]}#{method.name}#{format_args(method)}"
      block = format_block(method)
      heading += " #{block}" unless block.empty?
      heading += " (#{method.visibility})" unless method.visibility == :public
      named_entry([method], [heading, docs(method, 3)])
    end

    def named_entry(methods, parts)
      aliases = @verifier.run(methods.flat_map(&:aliases))
      summary = summary(methods.first)
      Entry.new(
        text: [*parts, list("Also known as", aliases.map(&:name))].compact.reject(&:empty?).join(SEPARATOR),
        group: :methods,
        names: (methods + aliases).map { |method| "#{SCOPES[method.scope]}#{method.name}" },
        detail: summary.empty? ? {} : {summary: summary}
      )
    end

    def summary(method)
      overloads = method.tags(:overload)
      docstring = (overloads.one? && method.docstring.empty?) ? overloads.first.docstring : method.docstring
      docstring = YARD::Docstring.new(docstring.sub(CALL_SEQ, "")) if docstring.match?(CALL_SEQ)
      returns = method.tags(:return)
      if docstring.summary.empty? && returns.one? && returns.first.text
        docstring = YARD::Docstring.new(returns.first.text.sub(/\A[a-z]/, &:upcase).strip)
      end
      @prose.call(docstring.summary, method, 4).strip.gsub(/\s*\n\s*/, " ")
    end

    def section(title, entries)
      entries.empty? ? [] : [Entry.new(text: "## #{title}"), *entries]
    end

    def docs(object, level)
      [@prose.call(object.docstring.to_s, object, level).strip, tags(object, level)].reject(&:empty?).join("\n\n")
    end

    def tags(object, level)
      YARD::Tags::Library.visible_tags.filter_map do |name|
        tags = object.tags(name)
        next if tags.empty? || (name == :return && returns_nothing?(object, tags))

        case name
        when :example then tags.map { |tag| example(object, tag) }.join("\n\n")
        when :overload then tags.map { |tag| overload(tag, level) }.join("\n\n")
        else listing(YARD::Tags::Library.labels[name], tags, object)
        end
      end.join("\n\n")
    end

    def returns_nothing?(object, tags)
      (object.respond_to?(:constructor?) && object.constructor?) || (tags.one? && tags.first.types == ["void"])
    end

    def listing(label, tags, object)
      entries = tags.map { |tag| entry(object, tag) }
      return "#{label}: #{entries.first}" if tags.one? && !tags.first.name

      "#{label}:\n#{entries.map { |entry| "- #{entry}" }.join("\n")}"
    end

    def entry(object, tag)
      case tag.tag_name
      when "see" then [@prose.link(tag.name), text(object, tag)].compact.join(" — ")
      when "option" then "`#{tag.name}` #{described(object, tag.pair)}"
      else described(object, tag)
      end
    end

    def described(object, tag)
      lead = [("`#{tag.name}`" if tag.name), qualifiers(tag)].compact.join(" ")
      [lead, text(object, tag)].reject { |part| part.nil? || part.empty? }.join(" — ")
    end

    def qualifiers(tag)
      types = "`#{format_types(tag.types, false)}`" if tag.types&.any?
      defaults = "default: `#{tag.defaults.join(", ")}`" if tag.respond_to?(:defaults) && tag.defaults&.any?
      qualifiers = [types, defaults].compact.join(", ")
      return if qualifiers.empty?

      tag.name ? "(#{qualifiers})" : qualifiers
    end

    def text(object, tag)
      return if tag.text.to_s.strip.empty?

      @prose.call(tag.text, object, 4).strip.gsub("\n", "\n  ")
    end

    def example(object, tag)
      title = tag.name.to_s.empty? ? "Example:" : "Example: #{@prose.call(tag.name, object, 4).strip}"
      "#{title}\n\n```ruby\n#{tag.text.sub(/\A\n+/, "").rstrip}\n```"
    end

    def overload(tag, level)
      ["Overload: `#{tag.signature}`", docs(tag, level)].reject(&:empty?).join("\n\n")
    end
  end
end
