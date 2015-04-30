require_relative "../lib/toml"

module Toml
  describe Parser do
    it "parses a single key/val pair" do
      expect(Parser.parse("mykey = myval")).to eq({ "mykey" => "myval" })
    end

    it "parses several key/val pairs" do
      expect(Parser.parse("mykey = myval\nanotherkey = anotherval")).to eq({ "mykey" => "myval", "anotherkey" => "anotherval" })
    end

    it "handles empty lines" do
      input = "a = b\n\n\n\nc = d"
      expect(Parser.parse(input)).to eq({"a" => "b", "c" => "d"})
    end

    it "tosses full line comments" do
      input = "a=b\n# foobar\nc=d"
      expect(Parser.parse(input)).to eq({"a" => "b", "c" => "d"})
    end

    it "matches a single comment" do
      input = "#comment"
      expect(Parser.parse(input)).to eq({})
    end
  end
end

