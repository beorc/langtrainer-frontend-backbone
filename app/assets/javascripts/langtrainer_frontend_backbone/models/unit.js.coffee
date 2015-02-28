class Langtrainer.LangtrainerApp.Models.Unit extends Backbone.Model
  initialize: ->
    Langtrainer.LangtrainerApp.trainingBus.on 'step:changed', @onStepChanged, @

  title: ->
    _.string.capitalize(@get('slug')).replace('_', ' ')

  getCurrentStep: ->
    new Langtrainer.LangtrainerApp.Models.Step(@get('current_step'))

  onStepChanged: (step) ->
    if @get('id') == step.get('unit_id')
      @set('current_step', step.attributes)
