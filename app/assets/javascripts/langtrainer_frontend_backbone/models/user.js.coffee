class Langtrainer.LangtrainerApp.Models.User extends Backbone.Model
  initialize: ->
    @listenTo @, 'change:token', @onTokenChanged

  getToken: ->
    @get('token') || $.cookie('token')

  onTokenChanged: ->
    if @signedIn()
      @save()
    else
      $.cookie('token', @get('token'))

  signedIn: ->
    !!@get('email')
