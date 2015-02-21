class Langtrainer.LangtrainerApp.Models.User extends Backbone.Model
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.Csrf)

  url: -> Langtrainer.LangtrainerApp.authApiEndpoint + '/api/users/update'

  initialize: ->
    @initCsrf()

    @listenTo @, 'change', @saveToCookie

  readAttribute: (attrName) ->
    attrValue = @get(attrName)
    result = null

    if attrValue?
      result = attrValue
    else
      result = $.cookie(attrName)

    result

  persist: ->
    if @signedIn() && @hasChanged()
      @resetCsrf()
      @save()

  saveToCookie: ->
    _.each @changedAttributes(), (value, key) ->
      $.cookie(key, String(value))

  signedIn: ->
    @get('activation_state') is 'active'

  getCurrentCourse: ->
    slug = @readAttribute('current_course_slug')
    collection = Langtrainer.LangtrainerApp.world.get('coursesCollection')

    result = null

    if slug?
      result = collection.findWhere(slug: slug)

    return result || collection.at(0)

  getCurrentForeignLanguage: ->
    slug = @readAttribute('language_slug') || 'en'

    nativeSlug = @getCurrentNativeLanguage().get('slug')
    collection = Langtrainer.LangtrainerApp.world.getForeignLanguages(nativeSlug)
    collection.findWhere(slug: slug) || collection.at(0)

  getCurrentNativeLanguage: ->
    slug = @readAttribute('native_language_slug') || 'ru'

    Langtrainer.LangtrainerApp.world.get('languagesCollection').findWhere(slug: slug)

  toggleQuestionHelp: ->
    enabled = @questionHelpEnabled()
    @set('question_help_enabled', !enabled)
    @persist()

  questionHelpEnabled: ->
    attrValue = @readAttribute('question_help_enabled')
    if attrValue?
      enabled = attrValue
    else
      enabled = true

    enabled == true || enabled == 'true'

  signOut: ->
    options =
      url: '/api/users/sign_out'
      method: 'delete'
      dataType: 'json'
      success: (response, status, xhr) ->
        Langtrainer.LangtrainerApp.globalBus.trigger('csrfChanged', xhr)
        Langtrainer.LangtrainerApp.globalBus.trigger('user:signedOut', response.user)
      error: ->
        alert(LangtrainerI18n.t('error'))

    options.headers = {}
    options.headers['X-CSRF-Token'] = @csrfToken()

    $.ajax options
