class Langtrainer.LangtrainerApp.Views.StepView extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/step_view']
  className: 'row'
  id: 'step-view'

  events:
    'keyup .lt-answer': 'onKeyup'
    'click .lt-show-next-word': 'onShowNextWord'
    'click .lt-check-answer': 'onCheckAnswer'
    'click .lt-show-right-answer': 'onShowRightAnswer'
    'click .lt-next-step': 'onNextStep'

  initialize: ->
    @listenTo Langtrainer.LangtrainerApp.world.get('step'), 'change', @render
    @listenTo Langtrainer.LangtrainerApp.world.get('language'), 'change', @render
    @listenTo Langtrainer.LangtrainerApp.world.get('nativeLanguage'), 'change', @render

    @listenTo @model, 'keyup:wrong', @onWrongKeyUp
    @listenTo @model, 'keyup:right', @onRightKeyUp
    @listenTo @model, 'keyup:empty', @onEmptyKeyUp

    @listenTo @model, 'verify:right', @onVerifyRight
    @listenTo @model, 'verify:wrong', @onVerifyWrong
    @listenTo @model, 'verify:error', @onVerifyError

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

  onShowRightAnswer: ->
    _.each @model.answers(@currentLanguage()), (rightAnswer, index) ->
      @$('.lt-answer-notification').sticky("Answer ##{index + 1}: #{rightAnswer}")

    @model.showRightAnswer()

  onNextStep: ->
    @model.nextStep()

  onCheckAnswer: ->
    @model.verifyAnswerOnServer(@$input.val(), @currentLanguage())

  onVerifyRight: ->
    @$('.lt-answer-notification').sticky('Right answer')

  onVerifyWrong: ->
    @$('.lt-answer-notification').sticky('Wrong answer')

  onVerifyError: ->
    @$('.lt-answer-notification').sticky('Oops... Something went wrong!')
