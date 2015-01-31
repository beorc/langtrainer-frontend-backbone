class Langtrainer.LangtrainerApp.Models.Step extends Backbone.Model
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

  verifyAnswer: (answer, language, context) ->
    that = @
    rightAnswer = null

    if answer.length is 0
      @triggerEvent(context, 'empty')
    else
      rightAnswer = _.find(@answers(language), (rightAnswer) -> !!that.matches(answer, rightAnswer))
      if rightAnswer?
        @triggerEvent(context, 'right')
      else
        @triggerEvent(context, 'wrong')

    rightAnswer

  triggerEvent: (context, eventName) ->
    @trigger(context + ':' + eventName)
