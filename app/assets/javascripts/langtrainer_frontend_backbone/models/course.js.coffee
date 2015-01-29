class Langtrainer.LangtrainerApp.Models.Course extends Backbone.Model
  initialize: ->
    @listenTo @, 'change:units', @reset

  reset: ->
    unitsCollection = new Langtrainer.LangtrainerApp.Collections.Units(@get('units'))
    @set('unitsCollection', unitsCollection)

  title: ->
    _.string.capitalize @get('slug')
