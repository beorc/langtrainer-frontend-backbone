$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "langtrainer_frontend_backbone/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "langtrainer_frontend_backbone"
  s.version     = LangtrainerFrontendBackbone::VERSION
  s.authors     = ["Yury Kotov"]
  s.email       = ["non-gi-suong@ya.ru"]
  s.homepage    = "https://github.com/langtrainer/langtrainer_frontend_backbone"
  s.summary     = "Backbone frontend for Langtrainer"
  s.description = "Backbone frontend for Langtrainer"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'railties'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'tilt-jade'
  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'font-awesome-rails'
  s.add_dependency 'bootstrap-select-rails'
end
