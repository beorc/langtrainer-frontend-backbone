class Langtrainer.LangtrainerApp.Models.User.Registration extends Backbone.Model
  _.extend(this.prototype, Langtrainer.LangtrainerApp.Models.Extensions.Validation)

  urlRoot: '/api/users/registration'

  initialize: ->
    @on 'error', @handleServerSideValidation, @
    @on 'sync', @onSignedUp, @

  validate: (attrs, options)->
    errors = {}
    if attrs.email.length == 0
      @pushValidationError(errors, 'email', "can't be empty")

    if attrs.password.length == 0
      @pushValidationError(errors, 'password', "can't be empty")

    if attrs.password_confirmation.length == 0
      @pushValidationError(errors, 'password_confirmation', "can't be empty")

    unless _.isEmpty(errors)
      return errors

  onSignedUp: ->
    Langtrainer.LangtrainerApp.globalBus.trigger('user:signedUp', @)
