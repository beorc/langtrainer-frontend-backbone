class Langtrainer.LangtrainerApp.Models.User.PasswordResetRequest extends Backbone.Model
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Validation)
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Csrf)

  url: -> Langtrainer.LangtrainerApp.authApiEndpoint + '/api/users/password_reset'

  initialize: ->
    @initCsrf()
    @on 'error', @handleServerSideValidation, @

  validate: (attrs, options)->
    errors = {}
    if attrs.email.length == 0
      @pushValidationError(errors, 'email', "can't be blank")

    unless _.isEmpty(errors)
      return errors
