# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'toml/version'

Gem::Specification.new do |spec|
  spec.name          = "toml"
  spec.version       = Toml::VERSION
  spec.authors       = ["Chris Schneider"]
  spec.email         = ["cschneider@comverge.com"]
  spec.summary       = %q{Example impl of a toml parser.}
  spec.description   = %q{Example impl of a toml parser.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "parslet", "~>1.7"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
end
