class Langtrainer.LangtrainerApp.Models.Step extends Backbone.Model
  question: (language) ->
    result = ''

    question = @get("#{language.get('slug')}_question")
    if question? && question.length > 0
      result = question

    if result.length == 0
      answer = @answers(language)[0]
      result = _.string.trim(answer)

    result

  answers: (language) ->
    @get("#{language.get('slug')}_answers").split('|')

  prepareAnswer: (answer) ->
    answer.replace(/\s{2,}/g, ' ')

  matches: (answer, rightAnswer) ->
    answerRegexp = XRegExp("^#{@prepareAnswer(answer)}", 'i')
    answerRegexp.exec rightAnswer

  verifyAnswer: (answer, language) ->
    that = @
    rightAnswer = null

    if answer.length is 0
      @trigger('answer:empty')
    else
      rightAnswer = _.find(@answers(language), (rightAnswer) -> !!that.matches(answer, rightAnswer))
      if rightAnswer?
        @trigger('answer:right')
      else
        @trigger('answer:wrong')

    rightAnswer
