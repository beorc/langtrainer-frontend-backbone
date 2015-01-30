class Langtrainer.LangtrainerApp.Views.StepView extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/step_view']
  className: 'row'
  id: 'step-view'

  render: ->
    @$el.hide().html(@template())
    @$el.slideToggle()
    @
