#= require_self
#= require ./backbone_patch
#= require_tree ./models/extensions
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./templates
#= require_tree ./views/extensions
#= require_tree ./views
#= require_tree ./routers

window.Langtrainer.LangtrainerApp =
  Models:
    Extensions: {}
  Collections: {}
  Views:
    Extensions: {}
    Dialogs: {}
  Routers: {}

  commonRouter: null
  world: null
  currentUser: null
  globalBus: _.extend({}, Backbone.Events)

  apiEndpoint: ''

  run: (initialData, successCallback, errorCallback)->
    @apiEndpoint = initialData.apiEndpoint
    @authApiEndpoint = initialData.authApiEndpoint

    @commonRouter = new Langtrainer.LangtrainerApp.Routers.CommonRouter

    onSignedIn = (userAttributes) =>
      @reset(userAttributes, successCallback, errorCallback)

    onSignedOut = (userAttributes) =>
      @reset(userAttributes, successCallback, errorCallback)

    @globalBus.on 'user:signedUp', @onSignedUp, @
    @globalBus.on 'user:signedIn', onSignedIn, @
    @globalBus.on 'user:signedOut', onSignedOut, @
    @globalBus.on 'signInDialog:hidden', @navigateRoot, @
    @globalBus.on 'signUpDialog:hidden', @navigateRoot, @

    @reset(initialData.currentUser, successCallback, errorCallback)

    Backbone.history.start()

  reset: (userAttributes, successCallback, errorCallback) ->
    @world ?= new Langtrainer.LangtrainerApp.Models.World
    @currentUser ?= new Langtrainer.LangtrainerApp.Models.User(userAttributes)

    @world.fetch(success: successCallback, error: errorCallback)

    Langtrainer.LangtrainerApp.globalBus.trigger('app:reset')

  onSignedUp: (userAttributes)->
    @currentUser.set('id', userAttributes.id)
    @currentUser.set('email', userAttributes.email)
    @currentUser.set('csrf_param', userAttributes.csrf_param)
    @currentUser.set('csrf_token', userAttributes.csrf_token)
    @currentUser.save()

  navigate: (fragment, options)->
    scroll = $(window).scrollTop()

    @commonRouter.navigate(fragment, options)

    $(window).scrollTop(scroll)

  navigateRoot: ->
    @navigate('/')

  navigateToSignIn: ->
    @navigate('sign_in', trigger: true)

  navigateToSignUp: ->
    @navigate('sign_up', trigger: true)

  clearCookies: ->
    _.each $.cookie(), (value, key) ->
      $.removeCookie(key)
