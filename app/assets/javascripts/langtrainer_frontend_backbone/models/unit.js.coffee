class Langtrainer.LangtrainerApp.Models.Unit extends Backbone.Model
  initialize: ->
    @listenTo Langtrainer.LangtrainerApp.world.get('step'), 'change', @onStepChanged

  title: ->
    _.string.capitalize(@get('slug')).replace(/_/g, ' ')

  onStepChanged: (step) ->
    if @get('id') == step.get('unit_id')
      @set('current_step', step.attributes)
