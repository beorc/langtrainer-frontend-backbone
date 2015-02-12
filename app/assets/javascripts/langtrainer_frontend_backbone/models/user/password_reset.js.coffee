class Langtrainer.LangtrainerApp.Models.User.PasswordReset extends Backbone.Model
  url: -> Langtrainer.LangtrainerApp.authApiEndpoint + '/api/users/password_resets/reset'
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Validation)
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Csrf)

  initialize: ->
    @initCsrf()
    @on 'error', @handleServerSideValidation, @

  validate: (attrs, options)->
    errors = {}

    if attrs.password.length == 0
      @pushValidationError(errors, 'password', "can't be blank")

    if attrs.password_confirmation.length == 0
      @pushValidationError(errors, 'password_confirmation', "can't be blank")

    unless _.isEmpty(errors)
      return errors
