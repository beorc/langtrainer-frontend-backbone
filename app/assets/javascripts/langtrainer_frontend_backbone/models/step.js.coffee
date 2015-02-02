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

  prepareAnswer: (answer) ->
    answer.replace(/\s{2,}/g, ' ')

  matches: (answer, rightAnswer) ->
    answerRegexp = XRegExp("^#{@prepareAnswer(answer)}", 'i')
    answerRegexp.exec rightAnswer

  nextWordMatches: (answer, rightAnswer) ->
    answerRegexp = XRegExp("^#{@prepareAnswer(answer)}([\\p{L}\\p{P}]*)\\s*([\\p{L}\\p{P}]*)")
    answerRegexp.exec rightAnswer

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
      url: @verifyAnswerUrl(answer)
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
