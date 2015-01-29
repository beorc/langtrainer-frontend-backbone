class Langtrainer.LangtrainerApp.Models.Unit extends Backbone.Model
  title: ->
    _.string.capitalize @get('slug')
