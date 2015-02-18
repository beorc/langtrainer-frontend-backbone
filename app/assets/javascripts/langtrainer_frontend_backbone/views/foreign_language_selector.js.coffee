class Langtrainer.LangtrainerApp.Views.ForeignLanguageSelector extends Langtrainer.LangtrainerApp.Views.LanguageSelector
  initialize: (options) ->
    super(options)
    Langtrainer.LangtrainerApp.globalBus.on 'nativeLanguage:changed', @onNativeLanguageChanged, @

  onNativeLanguageChanged: (language) ->
    nativeSlug = language.get('slug')
    languages = Langtrainer.LangtrainerApp.world.getForeignLanguages(nativeSlug)
    @collection = languages
    currentLanguage = @collection.findWhere(slug: @currentLanguageSlug) || @collection.at(0)
    currentLanguageSlug = currentLanguage.get('slug')

    if @currentLanguageSlug != currentLanguageSlug
      @currentLanguageSlug = currentLanguageSlug
      @render()
      Langtrainer.LangtrainerApp.globalBus.trigger('foreignLanguage:changed', @getCurrentLanguage())

  onChange: (ev) ->
    slug = $(ev.target).val()

    if slug != @currentLanguageSlug
      @currentLanguageSlug = slug
      Langtrainer.LangtrainerApp.globalBus.trigger('foreignLanguage:changed', @getCurrentLanguage())
