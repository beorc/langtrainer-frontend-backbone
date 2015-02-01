class Langtrainer.LangtrainerApp.Views.StepView extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/step_view']
  className: 'row'
  id: 'step-view'

  events:
    'keyup .lt-answer': 'onKeyup'
    'click .lt-show-next-word': 'onShowNextWord'
    'click .lt-check-answer': 'onCheckAnswer'

  initialize: ->
    @listenTo Langtrainer.LangtrainerApp.world.get('step'), 'change', @render

    @listenTo @model, 'keyup:wrong', @onWrongKeyUp
    @listenTo @model, 'keyup:right', @onRightKeyUp
    @listenTo @model, 'keyup:empty', @onEmptyKeyUp

  render: ->
    @$el.html(@template())
    @$('.lt-question').text(@model.question(@currentNativeLanguage()))
    @$input = @$('.lt-answer')
    @

  currentLanguage: ->
    Langtrainer.LangtrainerApp.currentUser.getCurrentLanguage()

  currentNativeLanguage: ->
    Langtrainer.LangtrainerApp.currentUser.getCurrentNativeLanguage()

  onKeyup: (event) ->
    if event.which != 13
      @model.verifyAnswer(@$input.val(), @currentLanguage(), 'keyup')
    true

  onWrongKeyUp: ->
    @$('.lt-wrong-answer').show()

  onRightKeyUp: ->
    @$('.lt-wrong-answer').hide()

  onEmptyKeyUp: ->
    @$('.lt-wrong-answer').hide()

  onShowNextWord: ->
    answer = @$input.val()
    matches = @model.nextWord(answer, @currentLanguage())

    if matches?
      ending = matches[1]

      if ending.length > 0
        @$input.val("#{answer}#{ending}")
      else
        nextWord = matches[2]

        if nextWord.length > 0
          @$input.val("#{answer} #{nextWord}")

      @model.verifyAnswer(@$input.val(), @currentLanguage(), 'keyup')

  onCheckAnswer: ->
    @model.verifyAnswerOnServer(@$input.val(), @currentLanguage())
