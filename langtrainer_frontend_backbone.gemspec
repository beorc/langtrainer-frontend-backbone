$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "langtrainer_frontend_backbone/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "langtrainer_frontend_backbone"
  s.version     = LangtrainerFrontendBackbone::VERSION
  s.authors     = ["Yury Kotov"]
  s.email       = ["bairkan@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of LangtrainerFrontendBackbone."
  s.description = "TODO: Description of LangtrainerFrontendBackbone."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  gem.add_dependency "railties"
  gem.add_dependency "rails-backbone"
  gem.add_dependency 'bootstrap-sass', '~> 3.3.3'
  gem.add_dependency 'coffee-rails', '~> 4.1.0'
  gem.add_dependency 'font-awesome-rails'
  gem.add_dependency 'styx'

  gem.add_development_dependency "jasmine-rails"
  gem.add_development_dependency "jasmine-jquery-rails"
end
