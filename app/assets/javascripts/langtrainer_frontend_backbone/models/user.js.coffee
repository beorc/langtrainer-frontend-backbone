class Langtrainer.LangtrainerApp.Models.User extends Backbone.Model
  initialize: ->
    @listenTo @, 'change', @onChanged
    @listenTo Langtrainer.LangtrainerApp.world, 'change', @onWorldChanged

  readAttribute: (attrName) ->
    @get(attrName) || $.cookie(attrName)

  onWorldChanged: (world) ->
    @set('token', world.get('token'))

    @listenTo world.get('course'), 'change:slug', @onCourseChanged
    @listenTo world.get('unit'), 'change:slug', @onUnitChanged
    @listenTo world.get('nativeLanguage'), 'change:slug', @onNativeLanguageChanged
    @listenTo world.get('language'), 'change:slug', @onLanguageChanged

    @onCourseChanged(world.get('course'))
    @onUnitChanged(world.get('unit'))
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

  getCourse: ->
    slug = @readAttribute('course_slug')
    collection = Langtrainer.LangtrainerApp.world.get('coursesCollection')

    if slug?
      return collection.findWhere(slug: slug)
    else
      return collection.at(0)

  getUnit: ->
    slug = @readAttribute('unit_slug')
    collection = Langtrainer.LangtrainerApp.world.get('course').get('unitsCollection')

    if slug?
      return collection.findWhere(slug: slug)
    else
      return collection.at(0)

  getLanguage: ->
    slug = @readAttribute('language_slug') || 'en'

    collection = Langtrainer.LangtrainerApp.world.get('languagesCollection')
    collection.findWhere(slug: slug) || collection.at(0)

  getNativeLanguage: ->
    slug = @readAttribute('native_language_slug') || 'ru'

    Langtrainer.LangtrainerApp.world.get('nativeLanguagesCollection').findWhere(slug: slug)

  onCourseChanged: (course) ->
    @set
      course_slug: course.get('slug')
      unit_slug: course.get('unitsCollection').at(0).get('slug')

  onUnitChanged: (unit) ->
    @set('unit_slug', unit.get('slug'))

  onNativeLanguageChanged: (nativeLanguage) ->
    @set('native_language_slug', nativeLanguage.get('slug'))

  onLanguageChanged: (language) ->
    @set('language_slug', language.get('slug'))
