# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'page_up/version'

Gem::Specification.new do |spec|
  spec.name          = "page_up"
  spec.version       = PageUp::VERSION
  spec.required_ruby_version = ">= 1.9.2"
  spec.authors       = ["Jon Rowe"]
  spec.email         = ["hello@jonrowe.co.uk"]
  spec.description   = %q{Simple paginator}
  spec.summary       = %q{Simple paginator}
  spec.homepage      = "https://github.com/JonRowe/page_up"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec",   "~> 2.14.0"
end
