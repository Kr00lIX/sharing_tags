# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sharing_tags/version'

Gem::Specification.new do |spec|
  spec.name          = "sharing_tags"
  spec.version       = SharingTags::VERSION
  spec.authors       = ["Anatoliy Kovalchuk"]
  spec.email         = ["kr00lix@gmail.com"]
  spec.summary       = %q{ Generate sharing tags for different contexts }
  spec.description   = %q{ Describe your sharing information for different contexts in one simple configuration file. }
  spec.homepage      = "https://github.com/Kr00lIX/sharing_tags"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails'
  spec.add_dependency 'hashie'
  spec.add_dependency 'slim'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rspec-html-matchers'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'pry'

end
