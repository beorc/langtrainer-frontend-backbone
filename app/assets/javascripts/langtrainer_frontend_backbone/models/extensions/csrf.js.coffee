Langtrainer.LangtrainerApp.Models.Extensions.Csrf =
  initCsrf: ->
    @set(Langtrainer.LangtrainerApp.currentUser.get('csrf_param'), @csrfToken())

  csrfToken: ->
    $('meta[name="csrf-token"]').attr('content')
