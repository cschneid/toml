require 'toml/version'
require 'parslet'

module Toml
  class Parser
    include Parslet

    def self.from_file(file)
      File.open(file) { |io| self.parse(io) }
    end

    def self.parse(io)
      instance = self.new(io)
      instance.parse
    end

    def initialize(io)
      @io = i
    end

    def parse
    end
  end
end
