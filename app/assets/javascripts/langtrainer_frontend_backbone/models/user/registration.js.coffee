class Langtrainer.LangtrainerApp.Models.User.Registration extends Backbone.Model
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Validation)
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Csrf)

  url: '/api/users/registration'

  initialize: ->
    @initCsrf()
    @on 'error', @handleServerSideValidation, @
    @on 'sync', @onSignedUp, @

  validate: (attrs, options)->
    errors = {}
    if attrs.email.length == 0
      @pushValidationError(errors, 'email', "can't be blank")

    if attrs.password.length == 0
      @pushValidationError(errors, 'password', "can't be blank")

    if attrs.password_confirmation.length == 0
      @pushValidationError(errors, 'password_confirmation', "can't be blank")

    unless _.isEmpty(errors)
      return errors

  onSignedUp: ->
    Langtrainer.LangtrainerApp.globalBus.trigger('user:signedUp', @get('user'))
