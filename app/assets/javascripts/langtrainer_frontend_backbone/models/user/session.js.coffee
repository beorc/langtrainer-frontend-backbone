class Langtrainer.LangtrainerApp.Models.User.Session extends Backbone.Model
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Validation)
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Csrf)
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.UserStatus)

  url: -> Langtrainer.LangtrainerApp.authApiEndpoint + '/api/users/session'

  initialize: ->
    @initCsrf()
    @on 'error', @handleServerSideValidation, @
    @on 'error', @handleUserStatus, @
    @on 'sync', @onSynced, @

  validate: (attrs, options)->
    errors = {}
    if attrs.email.length == 0
      @pushValidationError(errors, 'email', "can't be blank")

    if attrs.password.length == 0
      @pushValidationError(errors, 'password', "can't be blank")

    unless _.isEmpty(errors)
      return errors

  onSynced: (model, resp, options) ->
    Langtrainer.LangtrainerApp.globalBus.trigger('csrfChanged', options.xhr)
    Langtrainer.LangtrainerApp.globalBus.trigger('user:signedIn', resp.user)
