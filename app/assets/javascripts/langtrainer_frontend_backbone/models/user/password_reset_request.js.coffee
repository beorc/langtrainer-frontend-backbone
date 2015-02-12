class Langtrainer.LangtrainerApp.Models.User.PasswordResetRequest extends Backbone.Model
  url: -> Langtrainer.LangtrainerApp.authApiEndpoint + '/api/users/password_resets/request'
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Validation)
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Csrf)

  initialize: ->
    @initCsrf()
    @on 'error', @handleServerSideValidation, @

  validate: (attrs, options)->
    errors = {}
    if attrs.email.length == 0
      @pushValidationError(errors, 'email', "can't be blank")

    unless _.isEmpty(errors)
      return errors
