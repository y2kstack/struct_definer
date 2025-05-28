# lib/struct_definer.rb
require "struct_definer/version"
require "json"

module StructDefiner
  class User
    attr_accessor :name, :email
    def initialize(name:, email:)
      @name = name
      @email = email
    end
    def serialize
      { name: @name, email: @email }.to_json
    end
    def self.deserialize(data)
      parsed = JSON.parse(data)
      new(name: parsed["name"], email: parsed["email"])
    end
    def to_s
      "User(name: #{@name}, email: #{@email})"
    end
  end
end