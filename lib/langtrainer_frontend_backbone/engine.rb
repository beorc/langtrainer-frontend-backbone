module LangtrainerFrontendBackbone
  class Engine < ::Rails::Engine
    require 'rails-backbone'
    require 'styx'
    require 'tilt-jade'
    require 'coffee-rails'
    require 'jquery-rails'
  end
end
