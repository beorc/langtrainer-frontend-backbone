class Langtrainer.LangtrainerApp.Models.Step extends Backbone.Model
  question: (language) ->
    result = ''

    question = @get("#{language.get('slug')}_question")
    if question? && question.length > 0
      result = question

    if result.length == 0
      answer = @get("#{language.get('slug')}_answers").split('|')[0]
      result = _.string.trim(answer)

    result
