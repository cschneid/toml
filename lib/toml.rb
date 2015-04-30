require 'toml/version'
require 'parslet'

module Toml
  class Parser
    include Parslet

    def self.parse(str)
      instance = self.new(str)
      instance.parse
    end

    attr_reader :raw_string
    def initialize(raw_string)
      @raw_string = raw_string
    end

    rule(:key)    { (match('[a-z]').repeat).as(:key)   }
    rule(:equals) { any >> str("=") >> any             }
    rule(:value)  { (match('[a-z]').repeat).as(:value) }
    rule(:newline) { match('\n') }

    def parse
      parse_result = ((key >> equals >> value >> newline.maybe).repeat).parse(raw_string)

      parse_result.reduce({}) do |memo, result|
        key = result[:key].to_s
        val = result[:value].to_s
        memo[key] = val
        memo
      end
    end

  end
end
