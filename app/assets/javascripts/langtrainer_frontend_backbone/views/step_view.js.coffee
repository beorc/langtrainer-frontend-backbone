class Langtrainer.LangtrainerApp.Views.StepView extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/step_view']
  className: 'row'
  id: 'step-view'

  events:
    'keyup .answer': 'onKeyup'

  render: ->
    @$el.hide().html(@template())
    @$('.lt-question').text(@model.question(@curentLanguage()))
    @$el.slideToggle()
    @$input = @$('.lt-answer')
    @

  currentLanguage: ->
    Langtrainer.LangtrainerApp.currentUser.getCurrentLanguage()

  onKeyup: ->
    @model.verifyAnswer(@$input.val(), @currentLanguage())
    true
