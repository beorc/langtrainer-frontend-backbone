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
    @locales = initialData.locales

    @apiEndpoint = initialData.apiEndpoint
    @authApiEndpoint = initialData.authApiEndpoint

    @commonRouter = new Langtrainer.LangtrainerApp.Routers.CommonRouter

    onSignedIn = (userAttributes, options) =>
      @reset(userAttributes, {}, successCallback, errorCallback)

    onSignedOut = (userAttributes, options) =>
      @reset(userAttributes, {}, successCallback, errorCallback)

    @globalBus.on 'user:signedUp', @onSignedUp, @
    @globalBus.on 'user:signedIn', onSignedIn, @
    @globalBus.on 'user:signedOut', onSignedOut, @
    @globalBus.on 'signInDialog:hidden', @navigateRoot, @
    @globalBus.on 'signUpDialog:hidden', @navigateRoot, @
    @globalBus.on 'feedbackDialog:hidden', @navigateRoot, @
    @globalBus.on 'activateDialog:hidden', @navigateRoot, @
    @globalBus.on 'passwordResetDialog:hidden', @navigateRoot, @
    @globalBus.on 'csrfChanged', @resetCsrf, @

    @reset(initialData.currentUser, {}, successCallback, errorCallback)

    Backbone.history.start()

  resetCsrf: (xhr) ->
    param = xhr.getResponseHeader('X-CSRF-Param')
    token = xhr.getResponseHeader('X-CSRF-Token')

    $('meta[name="csrf-param"]').attr('content', param)
    $('meta[name="csrf-token"]').attr('content', token)

  reset: (userAttributes, worldAttributes, successCallback, errorCallback) ->
    @world = new Langtrainer.LangtrainerApp.Models.World(worldAttributes)
    @currentUser = new Langtrainer.LangtrainerApp.Models.User(userAttributes)
    if !@currentUser.signedIn()
      nativeLanguageSlug = $.cookie('native_language_slug')
      if nativeLanguageSlug?
        @currentUser.attributes.native_language_slug = nativeLanguageSlug

    @world.fetch(success: successCallback, error: errorCallback)

  onSignedUp: (userAttributes)->
    @currentUser.set('id', userAttributes.id)
    @currentUser.set('email', userAttributes.email)
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

  navigateToPasswordResetRequest: ->
    @navigate('password_reset_request', trigger: true)

  navigateToFeedback: ->
    @navigate('feedback', trigger: true)

  showActivateDialog: (email) ->
    model = new Langtrainer.LangtrainerApp.Models.User.Activation(email: email)
    view = new Langtrainer.LangtrainerApp.Views.Dialogs.Activate(model: model)
    view.render()

  showPasswordResetDialog: (token) ->
    view = new Langtrainer.LangtrainerApp.Views.Dialogs.PasswordReset(token)
    view.render()

  clearCookies: ->
    _.each $.cookie(), (value, key) ->
      $.removeCookie(key)

  locale: ->
    @currentUser.get('native_language_slug')

  t: (token) ->
    chain = token.split('.')
    result = @locales[@currentUser.get('native_language_slug')]

    _.each chain, (segment) ->
      result = result[segment]

    result

window.LangtrainerI18n = Langtrainer.LangtrainerApp
