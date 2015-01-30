class Langtrainer.LangtrainerApp.Models.World extends Backbone.Model
  url: -> Langtrainer.LangtrainerApp.apiEndpoint + '/world?token=' + @token

  initialize: ->
    @set('course', new Langtrainer.LangtrainerApp.Models.Course)
    @set('unit', new Langtrainer.LangtrainerApp.Models.Unit)
    @set('step', new Langtrainer.LangtrainerApp.Models.Step)
    @set('language', new Langtrainer.LangtrainerApp.Models.Language)
    @set('nativeLanguage', new Langtrainer.LangtrainerApp.Models.Language)

    coursesCollection = new Langtrainer.LangtrainerApp.Collections.Courses
    @set('coursesCollection', coursesCollection)

    nativeLanguagesCollection = new Langtrainer.LangtrainerApp.Collections.Languages
    @set('nativeLanguagesCollection', nativeLanguagesCollection)

    languagesCollection = new Langtrainer.LangtrainerApp.Collections.Languages
    @set('languagesCollection', languagesCollection)

    unitsCollection = new Langtrainer.LangtrainerApp.Collections.Units
    @set('unitsCollection', unitsCollection)

    @listenTo @, 'change:token', @reset

    @listenTo @get('course'), 'change:slug', @onCourseChanged
    @listenTo @get('nativeLanguage'), 'change:slug', @onNativeLanguageChanged


  reset: ->
    @get('coursesCollection').reset(@get('courses'))
    @get('nativeLanguagesCollection').reset(@get('languages'))

    @get('course').set Langtrainer.LangtrainerApp.currentUser.getCourse().attributes
    @get('unit').set Langtrainer.LangtrainerApp.currentUser.getUnit().attributes
    @get('step').set @get('unit').get('current_step')

    @get('nativeLanguage').set Langtrainer.LangtrainerApp.currentUser.getNativeLanguage().attributes

  onCourseChanged: (course) ->
    @get('unitsCollection').reset course.get('units')

  onNativeLanguageChanged: (nativeLanguage) ->
    nativeSlug = nativeLanguage.get('slug')
    languages = _.reject @get('languages'), (language) -> language.slug == nativeSlug
    @get('languagesCollection').reset languages

    @get('language').set Langtrainer.LangtrainerApp.currentUser.getLanguage().attributes
