class Langtrainer.LangtrainerApp.Views.NativeLanguageSelector extends Langtrainer.LangtrainerApp.Views.LanguageSelector
  events:
    'change select': 'onChange'

  onChange: (ev) ->
    slug = $(ev.target).val()

    if slug != @currentLanguageSlug
      @currentLanguageSlug = slug
      Langtrainer.LangtrainerApp.globalBus.trigger('nativeLanguage:changed', @getCurrentLanguage())
