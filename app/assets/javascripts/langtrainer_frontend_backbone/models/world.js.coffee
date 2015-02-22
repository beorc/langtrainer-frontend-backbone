class Langtrainer.LangtrainerApp.Models.World extends Backbone.Model
  url: -> Langtrainer.LangtrainerApp.apiEndpoint + '/world?token=' + Langtrainer.LangtrainerApp.currentUser.readAttribute('token')

  initialize: ->
    Langtrainer.LangtrainerApp.world = @

    @set('coursesCollection', new Langtrainer.LangtrainerApp.Collections.Courses)
    languages = _.map Langtrainer.LangtrainerApp.availableLocales, (locale) -> { slug: locale }
    @set('languagesCollection', new Langtrainer.LangtrainerApp.Collections.Languages(languages))

    @listenTo @, 'change:token', @reset

  getForeignLanguages: (nativeLanguageSlug) ->
    languages = @get('languagesCollection').reject (language) -> language.get('slug') == nativeLanguageSlug
    new Langtrainer.LangtrainerApp.Collections.Languages languages

  reset: ->
    Langtrainer.LangtrainerApp.currentUser.set('token', @get('token'))

    @get('coursesCollection').reset(@get('courses'))
    @get('languagesCollection').reset(@get('languages'))
