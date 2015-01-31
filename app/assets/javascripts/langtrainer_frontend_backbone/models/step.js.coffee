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

  matches: (answer, rightAnswer) ->
    answerRegexp = XRegExp("^#{answer}")
    answerRegexp.exec rightAnswer

  verifyAnswer: (answer, language) ->
    rightAnswer = null

    if answer.length is 0
      @trigger('answer:empty')
    else
      rightAnswer = _.find(@answers(language), (rightAnswer) -> rightAnswer.match("^#{answer}", 'i')
      if rightAnswer?
        @trigger('answer:right')
      else
        @trigger('answer:wrong')

    rightAnswer
