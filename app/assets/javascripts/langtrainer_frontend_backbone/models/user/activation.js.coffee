class Langtrainer.LangtrainerApp.Models.User.Activation extends Backbone.Model
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Csrf)

  url: -> Langtrainer.LangtrainerApp.authApiEndpoint + '/api/users/activation'

  initialize: ->
    @initCsrf()
