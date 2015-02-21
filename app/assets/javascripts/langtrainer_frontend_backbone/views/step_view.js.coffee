class Langtrainer.LangtrainerApp.Views.StepView extends Backbone.View
  _.extend(@prototype, Langtrainer.LangtrainerApp.Views.Extensions.Localized)

  template: JST['langtrainer_frontend_backbone/templates/step_view']
  className: 'row'
  id: 'step-view'

  STEPS_NUMBER_TO_SUGGEST_SIGN_UP: 10
  stepsCounter: 0

  events:
    'keyup .lt-answer': 'onKeyup'
    'keypress .lt-answer': 'onKeypress'
    'click .lt-show-next-word': 'onShowNextWord'
    'click .lt-check-answer': 'onCheckAnswer'
    'click .lt-show-right-answer': 'onShowRightAnswer'
    'click .lt-next-step': 'onNextStep'
    'click .lt-question-help-toggle': 'onQuestionHelpToggle'

  initialize: ->
    @listenTo Langtrainer.LangtrainerApp.trainingBus.on 'step:changed', @onStepChanged, @
    @listenTo Langtrainer.LangtrainerApp.trainingBus.on 'step:rightAnswer', @onVerifyRight, @
    @listenTo Langtrainer.LangtrainerApp.trainingBus.on 'step:wrongAnswer', @onVerifyWrong, @
    @listenTo Langtrainer.LangtrainerApp.trainingBus.on 'step:verificationError', @onVerifyError, @

    @listenTo Langtrainer.LangtrainerApp.globalBus.on 'foreignLanguage:changed', @onForeignLanguageChanged, @
    @listenTo Langtrainer.LangtrainerApp.globalBus.on 'nativeLanguage:changed', @onNativeLanguageChanged, @

    @listenTo Langtrainer.LangtrainerApp.currentUser, 'change:question_help_enabled', @onQuestionHelpChanged

    @listenTo Langtrainer.LangtrainerApp.trainingBus.on 'step:wrongInput', @onWrongKeyUp, @
    @listenTo Langtrainer.LangtrainerApp.trainingBus.on 'step:rightInput', @onRightKeyUp, @
    @listenTo Langtrainer.LangtrainerApp.trainingBus.on 'step:emptyInput', @onEmptyKeyUp, @

    @currentForeignLanguage = Langtrainer.LangtrainerApp.currentUser.getCurrentForeignLanguage()
    @currentNativeLanguage = Langtrainer.LangtrainerApp.currentUser.getCurrentNativeLanguage()

  render: ->
    @$el.html(@template())
    @$input = @$('.lt-answer')
    @$('.lt-check-answer').closest('li').popover
      title: ''
      content: LangtrainerI18n.t('step_view.popover.hotkey.check')
      placement: 'top'
      trigger: 'manual'

    @renderStep()

    @

  renderStep: ->
    @$('.lt-question').html(@model.question(@currentNativeLanguage))
    @$('.lt-answer').val('')
    @onQuestionHelpChanged()

    questionHelp = @model.questionHelp(@currentNativeLanguage)

    @$('.lt-question-notification').empty()

    if questionHelp? && questionHelp.length > 0
      @$('.lt-question-notification').sticky(questionHelp, autoclose: false)
      @$('.lt-question-help-toggle').removeClass('disabled')
    else
      @$('.lt-question-help-toggle').addClass('disabled')

    @

  onNativeLanguageChanged: (model) ->
    @currentNativeLanguage = model
    @renderStep()

  onForeignLanguageChanged: (model) ->
    @currentForeignLanguage = model
    @renderStep()

  onStepChanged: (model) ->
    @model = model
    @renderStep()

  toggleQuestionHelp: ->
    Langtrainer.LangtrainerApp.currentUser.toggleQuestionHelp()

  isVerifyKey: (event) ->
    event.which is 13 && !event.shiftKey

  onKeypress: (event) ->
    if @isVerifyKey(event)
      return false

    true

  onKeyup: (event) ->
    if @isVerifyKey(event)
      @verifyAnswerOnServer()
    else
      @model.verifyAnswer(@$input.val(), @currentForeignLanguage)
    true

  onWrongKeyUp: ->
    @$('.lt-wrong-answer').show()

  onRightKeyUp: ->
    @$('.lt-wrong-answer').hide()

  onEmptyKeyUp: ->
    @$('.lt-wrong-answer').hide()

  onShowNextWord: ->
    answer = @$input.val()
    matches = @model.nextWord(answer, @currentForeignLanguage)

    if matches?
      ending = matches[1]

      if ending.length > 0
        @$input.val("#{answer}#{ending}")
      else
        nextWord = matches[2]

        if nextWord.length > 0
          @$input.val("#{answer} #{nextWord}")

      @model.verifyAnswer(@$input.val(), @currentForeignLanguage)
    false

  onShowRightAnswer: ->
    answers = @model.answers(@currentForeignLanguage)
    _.each answers.reverse(), (rightAnswer, index) ->
      @$('.lt-answer-notification').sticky("#{LangtrainerI18n.t('step_view.popover.answer')} ##{answers.length - index}: #{rightAnswer}", autoclose: 10000)

    @model.showRightAnswer()
    false

  onNextStep: ->
    @model.nextStep()
    false

  verifyAnswerOnServer: ->
    @model.verifyAnswerOnServer(@$input.val(), @currentForeignLanguage)

  onCheckAnswer: ->
    @verifyAnswerOnServer()
    @showHotkeyPopover()
    false

  showHotkeyPopover: ->
    @$('.lt-check-answer').closest('li').popover('show')
    close = =>
      @$('.lt-check-answer').closest('li').popover('hide')
    setTimeout(close, 3000)

  onVerifyRight: ->
    @$('.lt-answer-notification').sticky(LangtrainerI18n.t('step_view.popover.right_answer'))
    if !Langtrainer.LangtrainerApp.currentUser.signedIn()
      @stepsCounter += 1
      if @stepsCounter > @STEPS_NUMBER_TO_SUGGEST_SIGN_UP
        @stepsCounter = 0
        @$('.lt-answer-notification').sticky(LangtrainerI18n.t('step_view.popover.sign_up'))

  onVerifyWrong: ->
    @$('.lt-answer-notification').sticky(LangtrainerI18n.t('step_view.popover.wrong_answer'))

  onVerifyError: ->
    @$('.lt-answer-notification').sticky(LangtrainerI18n.t('error'))

  onQuestionHelpToggle: ->
    Langtrainer.LangtrainerApp.currentUser.toggleQuestionHelp()
    false

  onQuestionHelpChanged: ->
    if Langtrainer.LangtrainerApp.currentUser.questionHelpEnabled()
      @$('.lt-question-help-disabled').addClass('hide')
      @$('.lt-question-help-enabled').removeClass('hide')
      @$('.lt-question-notification').slideDown()
    else
      @$('.lt-question-help-disabled').removeClass('hide')
      @$('.lt-question-help-enabled').addClass('hide')
      @$('.lt-question-notification').slideUp()
