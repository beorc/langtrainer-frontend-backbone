class Langtrainer.LangtrainerApp.Models.User.Registration extends Backbone.Model
  _.extend(this.prototype, Langtrainer.LangtrainerApp.Models.Extensions.Validation)

  url: '/api/users/registration'

  initialize: ->
    @set('authenticity_token', Langtrainer.LangtrainerApp.csrfToken)
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
    Langtrainer.LangtrainerApp.globalBus.trigger('user:signedUp', @)
    Langtrainer.LangtrainerApp.globalBus.trigger('user:signedIn', @)
