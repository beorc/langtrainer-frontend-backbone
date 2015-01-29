class Langtrainer.LangtrainerApp.Models.World extends Backbone.Model
  url: -> Langtrainer.LangtrainerApp.apiEndpoint + '/world?token=' + @token

  initialize: ->
    @set('course', new Langtrainer.LangtrainerApp.Models.Course)
    @set('unit', new Langtrainer.LangtrainerApp.Models.Unit)
    @set('step', new Langtrainer.LangtrainerApp.Models.Step)
    @set('language', new Langtrainer.LangtrainerApp.Models.Language)
    @set('nativeLanguage', new Langtrainer.LangtrainerApp.Models.Language)

    @listenTo @, 'change:token', @reset

  reset: ->
    coursesCollection = new Langtrainer.LangtrainerApp.Collections.Courses(@get('courses'))
    @set('coursesCollection', coursesCollection)

    nativeLanguagesCollection = new Langtrainer.LangtrainerApp.Collections.Languages(@get('languages'))
    @set('nativeLanguagesCollection', nativeLanguagesCollection)

    languagesCollection = new Langtrainer.LangtrainerApp.Collections.Languages
    @set('languagesCollection', languagesCollection)

    @get('course').set Langtrainer.LangtrainerApp.currentUser.getCourse().attributes
    @get('unit').set Langtrainer.LangtrainerApp.currentUser.getUnit().attributes
    @get('step').set @get('unit').get('current_step')

    @get('nativeLanguage').set Langtrainer.LangtrainerApp.currentUser.getNativeLanguage().attributes

    @listenTo @get('course'), 'change:slug', @onCourseChanged
    @listenTo @get('unit'), 'change:slug', @onUnitChanged
    @listenTo @get('nativeLanguage'), 'change:slug', @onNativeLanguageChanged
    @listenTo @get('language'), 'change:slug', @onLanguageChanged

    @resetLanguages()

    @get('language').set Langtrainer.LangtrainerApp.currentUser.getLanguage().attributes

  onCourseChanged: ->
    Langtrainer.LangtrainerApp.currentUser.set
      course_slug: @get('course').get('slug')
      unit_slug: @get('course').get('unitsCollection').at(0).get('slug')

  onUnitChanged: ->
    Langtrainer.LangtrainerApp.currentUser.set('unit_slug', @get('unit').get('slug'))

  onNativeLanguageChanged: ->
    newSlug = @get('nativeLanguage').get('slug')
    Langtrainer.LangtrainerApp.currentUser.set('native_language_slug', newSlug)

    @resetLanguages()

  resetLanguages: ->
    nativeSlug = @get('nativeLanguage').get('slug')
    languages = _.reject @get('languages'), (language) -> language.slug == nativeSlug
    @get('languagesCollection').reset languages

  onLanguageChanged: ->
    Langtrainer.LangtrainerApp.currentUser.set('language_slug', @get('language').get('slug'))
