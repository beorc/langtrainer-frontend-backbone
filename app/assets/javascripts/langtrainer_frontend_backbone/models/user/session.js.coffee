class Langtrainer.LangtrainerApp.Models.User.Session extends Backbone.Model
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Validation)

  url: '/api/users/session'

  initialize: ->
    @set('authenticity_token', Langtrainer.LangtrainerApp.csrfToken)
    @on 'error', @handleServerSideValidation, @
    @on 'sync', @onSignedIn, @

  validate: (attrs, options)->
    errors = {}
    if attrs.email.length == 0
      @pushValidationError(errors, 'email', "can't be blank")

    if attrs.password.length == 0
      @pushValidationError(errors, 'password', "can't be blank")

    unless _.isEmpty(errors)
      return errors

  onSignedIn: ->
    Langtrainer.LangtrainerApp.globalBus.trigger('user:signedIn', @)
