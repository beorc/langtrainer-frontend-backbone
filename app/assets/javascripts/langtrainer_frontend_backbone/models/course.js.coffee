class Langtrainer.LangtrainerApp.Models.Course extends Backbone.Model
  title: ->
    _.string.capitalize @get('slug')
