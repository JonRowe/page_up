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

  if RUBY_VERSION.to_f < 2
    spec.add_development_dependency "rake", '~> 10.0'
  elsif RUBY_VERSION.to_f < 2.3
    spec.add_development_dependency "rake", '~> 12.0'
  else
    spec.add_development_dependency "rake", '~> 13.0'
  end
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rspec",   "~> 3.9.0"
end
