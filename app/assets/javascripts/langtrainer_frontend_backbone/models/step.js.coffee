class Langtrainer.LangtrainerApp.Models.Step extends Backbone.Model
  baseParams: ->
    result = '?token=' + Langtrainer.LangtrainerApp.currentUser.readAttribute('token')
    result += '&unit=' + Langtrainer.LangtrainerApp.world.get('unit').get('id')
    result += '&step=' + Langtrainer.LangtrainerApp.world.get('step').get('id')
    result += '&native_language=' + Langtrainer.LangtrainerApp.world.get('nativeLanguage').get('slug')
    result += '&language=' + Langtrainer.LangtrainerApp.world.get('language').get('slug')

  nextWordUrl: ->
    result = Langtrainer.LangtrainerApp.apiEndpoint + '/help_next_word'
    result += @baseParams()

  verifyAnswerUrl: (answer) ->
    result = Langtrainer.LangtrainerApp.apiEndpoint + '/verify_answer'
    result += @baseParams()
    result += '&answer=' + answer

  nextStepUrl: ->
    result = Langtrainer.LangtrainerApp.apiEndpoint + '/next_step'
    result += @baseParams()

  showRightAnswerUrl: ->
    result = Langtrainer.LangtrainerApp.apiEndpoint + '/show_right_answer'
    result += @baseParams()

  question: (language) ->
    result = ''

    question = @get("#{language.get('slug')}_question")
    if question? && question.length > 0
      result = question

    if result.length == 0
      answer = @answers(language)[0]
      result = _.string.trim(answer)

    _.string.capitalize result

  answers: (language) ->
    @get("#{language.get('slug')}_answers").split('|')

  sanitizeText: (text) ->
    result = text
    result = result.replace(/(\n\r|\n|\r)/g, ' ')
    result = result.replace(/\s{2,}/g, ' ')

  sanitizeForRegex: (text) ->
    result = text
    result = result.replace(/\?/g, '\\?')

  questionHelp: (language) ->
    @get("#{language.get('slug')}_help")

  matches: (answer, rightAnswer) ->
    answerRegexp = XRegExp("^#{@sanitizeText(@sanitizeForRegex(answer))}", 'i')
    answerRegexp.exec @sanitizeText(rightAnswer)

  nextWordMatches: (answer, rightAnswer) ->
    answerRegexp = XRegExp("^#{@sanitizeText(@sanitizeForRegex(answer))}([\\p{L}\\p{P}]*)\\s*([\\p{L}\\p{P}]*)")
    answerRegexp.exec @sanitizeText(rightAnswer)

  verifyAnswer: (answer, language, context) ->
    that = @
    rightAnswer = null

    if answer.length is 0
      @triggerEvent(context, 'empty')
    else
      rightAnswer = _.find @answers(language), (rightAnswer) ->
        !!that.matches(answer, rightAnswer)

      if rightAnswer?
        @triggerEvent(context, 'right')
      else
        @triggerEvent(context, 'wrong')

    rightAnswer

  triggerEvent: (context, eventName) ->
    @trigger(context + ':' + eventName)

  nextWord: (answer, language) ->
    $.ajax
      url: @nextWordUrl()
      dataType: 'json'

    that = @
    result = null

    _.find @answers(language), (rightAnswer) ->
      result = that.nextWordMatches(answer, rightAnswer)
      !!result

    result

  verifyAnswerOnServer: (answer, language) ->
    that = @
    $.ajax
      url: @verifyAnswerUrl(@sanitizeText(answer))
      dataType: 'json'
      success: (response) ->
        if response
          that.set response
          that.trigger('change', that)
          that.trigger('verify:right')
        else
          that.trigger('verify:wrong')
      error: ->
        that.trigger('verify:error')

  nextStep: ->
    that = @
    $.ajax
      url: @nextStepUrl()
      dataType: 'json'
      success: (response) ->
        that.set response
        that.trigger('change', that)
      error: ->
        that.trigger('verify:error')

  showRightAnswer: ->
    $.ajax
      url: @showRightAnswerUrl()
      dataType: 'json'
