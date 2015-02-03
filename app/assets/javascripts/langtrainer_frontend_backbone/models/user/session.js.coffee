class Langtrainer.LangtrainerApp.Models.User.Session extends Backbone.Model
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Validation)

  urlRoot: '/api/users/session'

  initialize: ->
    @on 'error', @handleServerSideValidation, @
    @on 'sync', @onSignedIn, @

  validate: (attrs, options)->
    errors = {}
    if attrs.email.length == 0
      @pushValidationError(errors, 'email', "can't be empty")

    if attrs.password.length == 0
      @pushValidationError(errors, 'password', "can't be empty")

    unless _.isEmpty(errors)
      return errors

  onSignedIn: ->
    Langtrainer.LangtrainerApp.globalBus.trigger('user:signedIn', @)
