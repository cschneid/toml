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
      input = '#comment'
      expect(Parser.parse(input)).to eq({})
    end

    it "handles a partial line comment" do
      input = 'a=c# C should be just the single char'
      expect(Parser.parse(input)).to eq({"a" => "c"})
    end

    it "doesn't consume trailing spaces as part of a value" do
      input = 'a = d      '
      expect(Parser.parse(input)).to eq({"a" => "d"})
    end

    it "parses quoted values" do
      input = 'a = "ab#c"'
      expect(Parser.parse(input)).to eq({"a" => "ab#c"})
    end
  end
end

