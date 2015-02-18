#= require_self
#= require ./backbone_patch
#= require_tree ./models/extensions
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./templates
#= require_tree ./views/extensions
#= require_tree ./views/base
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
  trainingBus: _.extend({}, Backbone.Events)

  apiEndpoint: ''
  locales: {}

  run: (initialData, successCallback, errorCallback)->
    @locales = initialData.locales || {}

    @apiEndpoint = initialData.apiEndpoint
    @authApiEndpoint = initialData.authApiEndpoint

    @commonRouter = new Langtrainer.LangtrainerApp.Routers.CommonRouter

    onSignedIn = (userAttributes, options) =>
      @reset(userAttributes, {}, successCallback, errorCallback)

    onSignedOut = (userAttributes, options) =>
      @reset(userAttributes, {}, successCallback, errorCallback)

    @globalBus.on 'user:signedIn', onSignedIn, @
    @globalBus.on 'user:signedOut', onSignedOut, @
    @globalBus.on 'signInDialog:hidden', @navigateRoot, @
    @globalBus.on 'signUpDialog:hidden', @navigateRoot, @
    @globalBus.on 'feedbackDialog:hidden', @navigateRoot, @
    @globalBus.on 'activateDialog:hidden', @navigateRoot, @
    @globalBus.on 'passwordResetRequestDialog:hidden', @navigateRoot, @
    @globalBus.on 'csrfChanged', @resetCsrf, @
    @globalBus.on 'step:rightAnswer', @persistUser, @
    @globalBus.on 'step:wrongAnswer', @persistUser, @
    @globalBus.on 'nativeLanguage:changed', @onNativeLanguageChanged, @
    @globalBus.on 'foreignLanguage:changed', @onForeignLanguageChanged, @

    @trainingBus.on 'course:changed', @onCourseChanged, @
    @trainingBus.on 'unit:changed', @onUnitChanged, @

    @reset(initialData.currentUser, {}, successCallback, errorCallback)

    Langtrainer.LangtrainerApp.globalBus.trigger('application:start')

    Backbone.history.start()

  onCourseChanged: (course) ->
    @currentUser.set('current_course_slug', course.get('slug'))
    @currentUser.persist()
    Langtrainer.LangtrainerApp.trainingBus.trigger('unit:changed', course.getCurrentUnit())

  onUnitChanged: (unit) ->
    $.cookie('current_unit_slug', unit.get('slug'))
    step = new Langtrainer.LangtrainerApp.Models.Step(unit.get('current_step'))
    @trainingBus.trigger('step:changed', step)

  onNativeLanguageChanged: (language) ->
    Langtrainer.LangtrainerApp.currentUser.set('native_language_slug', language.get('slug'))
    Langtrainer.LangtrainerApp.globalBus.trigger('localeChanged', language.get('slug'))

  onForeignLanguageChanged: (language) ->
    Langtrainer.LangtrainerApp.currentUser.set('language_slug', language.get('slug'))

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

  persistUser: ->
    @currentUser.persist()

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

  showActivateDialog: (id) ->
    model = new Langtrainer.LangtrainerApp.Models.User.Activation(id: id)
    view = new Langtrainer.LangtrainerApp.Views.Dialogs.Activate(model: model)
    view.render()

  showPasswordResetDialog: (token) ->
    model = new Langtrainer.LangtrainerApp.Models.User.PasswordReset(token: token)
    view = new Langtrainer.LangtrainerApp.Views.Dialogs.PasswordReset(model: model)
    view.render()

  clearCookies: ->
    _.each $.cookie(), (value, key) ->
      $.removeCookie(key)

  locale: ->
    @currentUser.get('native_language_slug')

  t: (token) ->
    chain = token.split('.')
    result = @locales[@currentUser.get('native_language_slug')]

    if result
      _.each chain, (segment) ->
        result = result[segment]

    result

window.LangtrainerI18n = Langtrainer.LangtrainerApp
