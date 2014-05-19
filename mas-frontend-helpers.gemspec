$:.push File.expand_path("../lib", __FILE__)

require 'mas/frontend/helpers/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name          = "mas-frontend-helpers"
  s.version       = MAS::Frontend::Helpers::Version::STRING
  s.authors       = ['Money Advice Service', 'Gareth Visagie']
  s.email         = ['development.team@moneyadviceservice.org.uk', 'gareth@gjvis.com']
  s.summary       = %q{Useful utilities for creating Ruby web UIs}
  s.description   = %q{Useful utilities for creating Ruby web UIs, use in conjunction with https://github.com/moneyadviceservice/frontend-assets}
  s.homepage      = 'https://github.com/moneyadviceservice/mas-frontend-helpers'
  s.license       = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.18"

  s.add_development_dependency 'mas-build', '~> 2.0'
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 2.0'
  s.add_development_dependency 'rspec-rails'
end

