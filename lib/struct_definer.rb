# lib/struct_definer.rb
require "struct_definer/version"

module StructDefiner
  class Error < StandardError; end

  # Base class for our defined messages
  class Message
    def initialize(attributes = {})
      self.class.defined_fields.each do |field_name, type_info|
        value = attributes[field_name] || attributes[field_name.to_s]
        if value.nil? && type_info[:required]
          raise ArgumentError, "Missing required field: #{field_name}"
        end
        # Simple type checking (can be expanded)
        if value && type_info[:type] == :string && !value.is_a?(String)
          raise TypeError, "Field '#{field_name}' expected String, got #{value.class}"
        end
        if value && type_info[:type] == :integer && !value.is_a?(Integer)
          raise TypeError, "Field '#{field_name}' expected Integer, got #{value.class}"
        end
        instance_variable_set("@#{field_name}", value)
        self.class.send(:attr_accessor, field_name) unless self.class.method_defined?(field_name)
      end
    end

    def self.defined_fields
      @defined_fields ||= {}
    end

    def self.field(name, type:, required: false)
      defined_fields[name.to_sym] = { type: type, required: required }
      attr_accessor name # Define accessor
    end

    def to_h
      self.class.defined_fields.keys.each_with_object({}) do |field_name, hash|
        hash[field_name] = instance_variable_get("@#{field_name}")
      end
    end
  end

  # DSL method to define a new message type
  def self.define_message(class_name_suffix, &block)
    class_name = "#{class_name_suffix.to_s.capitalize}Message"
    # Ensure the class is defined under the StructDefiner module or globally
    # For simplicity, let's define it globally for easier access in the consuming app
    klass = Class.new(Message, &block)
    Object.const_set(class_name, klass) # Define it in the global namespace
    # To define under StructDefiner:
    # StructDefiner.const_set(class_name, klass)
    klass
  end
end