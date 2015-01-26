module LangtrainerFrontendBackbone
  class Engine < ::Rails::Engine
    require 'tilt-jade'
    require 'jquery-rails'
    require 'bootstrap-sass'
    require 'bootstrap-select-rails'
  end
end
