Langtrainer.LangtrainerApp.Views.Extensions.Localized =
  initLocalization: (options) ->
    Langtrainer.LangtrainerApp.globalBus.on 'localeChanged', options.onLocaleChanged, @
