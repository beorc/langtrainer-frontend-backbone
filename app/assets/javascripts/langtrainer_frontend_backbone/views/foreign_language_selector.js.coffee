class Langtrainer.LangtrainerApp.Views.ForeignLanguageSelector extends Langtrainer.LangtrainerApp.Views.LanguageSelector
  onChange: (ev) ->
    slug = $(ev.target).val()

    if slug != @currentLanguageSlug
      @currentLanguageSlug = slug
      Langtrainer.LangtrainerApp.globalBus.trigger('foreignLanguage:changed', @getCurrentLanguage())
