class Langtrainer.LangtrainerApp.Models.User extends Backbone.Model
  initialize: ->
    @listenTo @, 'change:token change:course_slug change:language_slug change:native_language_slug', @onChanged
    @listenTo Langtrainer.LangtrainerApp.world, 'change', @onWorldChanged

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
        $.cookie(key, value)

  signedIn: ->
    !!@get('email')

  getCurrentCourse: ->
    slug = @readAttribute('course_slug')
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
    @set course_slug: course.get('slug')

  onNativeLanguageChanged: (nativeLanguage) ->
    @set('native_language_slug', nativeLanguage.get('slug'))

  onLanguageChanged: (language) ->
    @set('language_slug', language.get('slug'))
