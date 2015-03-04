class Langtrainer.LangtrainerApp.Models.Unit extends Backbone.Model
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.HavingTitle)

  initialize: ->
    Langtrainer.LangtrainerApp.trainingBus.on 'step:changed', @onStepChanged, @

  getCurrentStep: ->
    new Langtrainer.LangtrainerApp.Models.Step(@get('current_step'))

  onStepChanged: (step) ->
    if @get('id') == step.get('unit_id')
      @set('current_step', step.attributes)
