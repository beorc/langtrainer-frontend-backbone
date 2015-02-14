class Langtrainer.LangtrainerApp.Models.User.Activation extends Backbone.Model
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Csrf)

  url: -> Langtrainer.LangtrainerApp.authApiEndpoint + '/api/users/activation'

  initialize: ->
    @initCsrf()
    @on 'sync', @onSynced, @

  onSynced: (model, resp, options) ->
    Langtrainer.LangtrainerApp.globalBus.trigger('csrfChanged', options.xhr)
    Langtrainer.LangtrainerApp.globalBus.trigger('user:signedIn', resp.user)
