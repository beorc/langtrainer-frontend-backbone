class Langtrainer.LangtrainerApp.Models.Language extends Backbone.Model
  title: ->
    titles = { ru: 'Russian', en: 'English' }
    titles[@get('slug')]
