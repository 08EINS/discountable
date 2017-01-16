# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'discountable/version'

Gem::Specification.new do |spec|
  spec.name          = "discountable"
  spec.version       = Discountable::VERSION
  spec.authors       = ["Stefan Staub", "Joel Ambass"]
  spec.email         = ["ste.staub@gmail.com", "joel.ambass@08eins.ch"]
  spec.summary       = %q{Nicely handle monetary discounts}
  spec.description   = ''
  spec.homepage      = "https://github.com/08eins/discountable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "money", ">= 6.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "activerecord", ">= 4.2"
  spec.add_development_dependency "sqlite3", ">= 1.3"
end
