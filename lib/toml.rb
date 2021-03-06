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
    rule(:equals) { whitespace >> str("=") >> whitespace }

    rule(:bare_value)   { (match('[a-z]').repeat(1)).as(:value) }
    rule(:quoted_value) { (str('"') >> (match('[^"]').repeat).as(:value) >> str('"')) }
    rule(:value) { (bare_value | quoted_value) >> match('\s').repeat }

    rule(:newline) { match('\n') }
    rule(:comment) { (str("#") >> match('[^\n]').repeat).as(:comment) }
    rule(:whitespace) { str(" ").repeat }

    rule(:key_val) { key >> equals >> value }

    def parse
      parser = ((key_val >> newline.repeat) |
                (comment >> newline.repeat)
               ).repeat >> newline.repeat
      parse_result = parser.parse(raw_string)

      parse_result.reduce({}) do |memo, result|
        next memo if result[:comment]

        key = result[:key].to_s
        val = result[:value].to_s
        memo[key] = val
        memo
      end
    end

  end
end
