class Langtrainer.LangtrainerApp.Models.User extends Backbone.Model
  url: '/api/users/user'

  initialize: ->
    @set('authenticity_token', Langtrainer.LangtrainerApp.csrfToken)
    @listenTo @, 'change:token change:current_course_slug change:language_slug change:native_language_slug change:question_help_enabled', @onChanged

    if Langtrainer.LangtrainerApp.world.has('token')
      @onWorldChanged(Langtrainer.LangtrainerApp.world)
    else
      @listenTo Langtrainer.LangtrainerApp.world, 'change:token', @onWorldChanged

  readAttribute: (attrName) ->
    @get(attrName) || $.cookie(attrName)

  onWorldChanged: (world) ->
    @set('token', world.get('token'))

    @listenTo world.get('course'), 'change:slug', @onCourseChanged
    @listenTo world.get('nativeLanguage'), 'change:slug', @onNativeLanguageChanged
    @listenTo world.get('language'), 'change:slug', @onLanguageChanged

    @onCourseChanged(world.get('course'))
    @onNativeLanguageChanged(world.get('nativeLanguage'))
    @onLanguageChanged(world.get('language'))

  onChanged: ->
    if @signedIn()
      @save()
    else
      _.each @changedAttributes(), (value, key) ->
        $.cookie(key, String(value))

  signedIn: ->
    !!@get('email')

  getCurrentCourse: ->
    slug = @readAttribute('current_course_slug')
    collection = Langtrainer.LangtrainerApp.world.get('coursesCollection')

    result = null

    if slug?
      result = collection.findWhere(slug: slug)

    return result || collection.at(0)

  getCurrentLanguage: ->
    slug = @readAttribute('language_slug') || 'en'

    collection = Langtrainer.LangtrainerApp.world.get('languagesCollection')
    collection.findWhere(slug: slug) || collection.at(0)

  getCurrentNativeLanguage: ->
    slug = @readAttribute('native_language_slug') || 'ru'

    Langtrainer.LangtrainerApp.world.get('nativeLanguagesCollection').findWhere(slug: slug)

  onCourseChanged: (course) ->
    @set current_course_slug: course.get('slug')

  onNativeLanguageChanged: (nativeLanguage) ->
    @set('native_language_slug', nativeLanguage.get('slug'))

  onLanguageChanged: (language) ->
    @set('language_slug', language.get('slug'))

  toggleQuestionHelp: ->
    enabled = @questionHelpEnabled()
    @set('question_help_enabled', String(!enabled))

  questionHelpEnabled: ->
    enabled = @readAttribute('question_help_enabled') || 'true'
    enabled == 'true'
