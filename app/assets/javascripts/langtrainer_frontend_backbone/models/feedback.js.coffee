class Langtrainer.LangtrainerApp.Models.Feedback extends Backbone.Model
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Validation)

  urlRoot: '/api/feedback'

  initialize: ->
    if Langtrainer.LangtrainerApp.currentUser.signedIn()
      unless @has('email')
        @set('email', Langtrainer.LangtrainerApp.currentUser.get('email'))

    @on 'error', @handleServerSideValidation, @

  validate: (attrs, options)->
    errors = {}
    if attrs.email.length == 0
      @pushValidationError(errors, 'email', 'не может быть пустым')

    if attrs.message.length == 0
      @pushValidationError(errors, 'message', 'не может быть пустым')

    unless _.isEmpty(errors)
      return errors
