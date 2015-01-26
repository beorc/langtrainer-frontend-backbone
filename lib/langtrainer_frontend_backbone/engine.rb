module LangtrainerFrontendBackbone
  class Engine < ::Rails::Engine
    require 'rails-backbone'
    require 'styx'
    require 'tilt-jade'
  end
end
