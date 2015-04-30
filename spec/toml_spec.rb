require_relative "../lib/toml"

module Toml
  describe Parser do
    it "parses a single key/val pair" do
      expect(Parser.parse("mykey = myval")).to eq({ "mykey" => "myval" })
    end

    it "parses several key/val pairs" do
      expect(Parser.parse("mykey = myval\nanotherkey = anotherval")).to eq({ "mykey" => "myval", "anotherkey" => "anotherval" })
    end
  end
end

