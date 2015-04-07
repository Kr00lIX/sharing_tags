# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sharing_tags/version'

Gem::Specification.new do |spec|
  spec.name          = 'sharing_tags'
  spec.version       = SharingTags::VERSION
  spec.authors       = ['Anatoliy Kovalchuk']
  spec.email         = ['kr00lix@gmail.com']
  spec.summary       = %q{ Generate sharing tags for different contexts }
  spec.description   = %q{ Describe your sharing information for different contexts in one simple configuration file. }
  spec.homepage      = 'https://github.com/Kr00lIX/sharing_tags'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rails',  '~> 4.0'
  spec.add_dependency 'hashie', '~> 3.4'
  spec.add_dependency 'slim',   '~> 3.0'
  spec.add_dependency 'coffee-script', '~> 2.3'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'rspec-nc', '~> 0.2'
  spec.add_development_dependency 'rspec-rails', '~> 3.2'
  spec.add_development_dependency 'rspec-html-matchers', '~> 0.7'
  spec.add_development_dependency 'ammeter',  '1.1.2'
  spec.add_development_dependency 'teaspoon', '~> 0.9'
  spec.add_development_dependency 'guard', '~> 2.12'
  spec.add_development_dependency 'guard-rspec', '~> 4.5'
  spec.add_development_dependency 'guard-teaspoon', '~> 0.8'
  spec.add_development_dependency 'sqlite3', '~> 1.3'
  spec.add_development_dependency 'pry', '~> 0.10'

end
