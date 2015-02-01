class Langtrainer.LangtrainerApp.Models.Unit extends Backbone.Model
  initialize: ->
    @currentStep = new Langtrainer.LangtrainerApp.Models.Step(@get('current_step'))
    @listenTo Langtrainer.LangtrainerApp.world.get('step'), 'change', @onStepChanged

  title: ->
    _.string.capitalize(@get('slug')).replace(/_/g, ' ')

  getCurrentStep: ->
    @currentStep

  onStepChanged: (step) ->
    if @get('id') == step.get('unit_id')
      @currentStep = step
