Langtrainer.LangtrainerApp.Models.Extensions.Csrf =
  initCsrf: ->
    @set(Langtrainer.LangtrainerApp.currentUser.get('csrf_param'), Langtrainer.LangtrainerApp.currentUser.get('csrf_token'))
