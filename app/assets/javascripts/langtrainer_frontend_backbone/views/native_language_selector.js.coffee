class Langtrainer.LangtrainerApp.Views.NativeLanguageSelector extends Langtrainer.LangtrainerApp.Views.LanguageSelector
  initialize: (options) ->
    super(options)
    Langtrainer.LangtrainerApp.globalBus.trigger('nativeLanguage:changed', @getCurrentLanguage())

  onChange: (ev) ->
    slug = $(ev.target).val()

    if slug != @currentLanguageSlug
      @currentLanguageSlug = slug
      Langtrainer.LangtrainerApp.globalBus.trigger('nativeLanguage:changed', @getCurrentLanguage())
