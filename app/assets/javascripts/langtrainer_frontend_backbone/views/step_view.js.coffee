class Langtrainer.LangtrainerApp.Views.StepView extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/step_view']
  className: 'row'
  id: 'step-view'

  events:
    'keyup .lt-answer': 'onKeyup'

  initialize: ->
    @listenTo @model, 'keyup:wrong', @onWrongKeyUp
    @listenTo @model, 'keyup:right', @onRightKeyUp
    @listenTo @model, 'keyup:empty', @onEmptyKeyUp

  render: ->
    @$el.hide().html(@template())
    @$('.lt-question').text(@model.question(@currentNativeLanguage()))
    @$el.slideToggle()
    @$input = @$('.lt-answer')
    @

  currentLanguage: ->
    Langtrainer.LangtrainerApp.currentUser.getCurrentLanguage()

  currentNativeLanguage: ->
    Langtrainer.LangtrainerApp.currentUser.getCurrentNativeLanguage()

  onKeyup: ->
    @model.verifyAnswer(@$input.val(), @currentLanguage(), 'keyup')
    true

  onWrongKeyUp: ->
    @$('.lt-wrong-answer').show()

  onRightKeyUp: ->
    @$('.lt-wrong-answer').hide()

  onEmptyKeyUp: ->
    @$('.lt-wrong-answer').hide()
