class Langtrainer.LangtrainerApp.Models.Feedback extends Backbone.Model
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Validation)
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Csrf)

  urlRoot: '/api/feedback'

  initialize: ->
    @initCsrf()
    if Langtrainer.LangtrainerApp.currentUser.signedIn()
      unless @has('email')
        @set('email', Langtrainer.LangtrainerApp.currentUser.get('email'))

    @on 'error', @handleServerSideValidation, @

  validate: (attrs, options)->
    errors = {}
    if attrs.email.length == 0
      @pushValidationError(errors, 'email', "can't be blank")

    if attrs.message.length == 0
      @pushValidationError(errors, 'message', "can't be blank")

    unless _.isEmpty(errors)
      return errors
