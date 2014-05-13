# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mas/frontend/helpers/version'

Gem::Specification.new do |spec|
  spec.name          = 'mas-frontend-helpers'
  spec.version       = MAS::Frontend::Helpers::Version::STRING
  spec.authors       = ['Money Advice Service', 'Gareth Visagie']
  spec.email         = ['development.team@moneyadviceservice.org.uk', 'gareth@gjvis.com']
  spec.summary       = %q{Useful utilities for creating Ruby web UIs}
  spec.description   = %q{Useful utilities for creating Ruby web UIs, use in conjunction with https://github.com/moneyadviceservice/frontend-assets}
  spec.homepage      = 'https://github.com/moneyadviceservice/mas-frontend-helpers'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'actionpack'

  spec.add_development_dependency 'activemodel', '>= 3.2.1'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.add_development_dependency 'mas-build', '~> 2.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.0'
end
