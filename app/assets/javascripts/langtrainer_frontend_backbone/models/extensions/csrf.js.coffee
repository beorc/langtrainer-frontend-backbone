Langtrainer.LangtrainerApp.Models.Extensions.Csrf =
  initCsrf: ->
    @set(@csrfParam(), @csrfToken())

  csrfParam: ->
    $('meta[name="csrf-param"]').attr('content')

  csrfToken: ->
    $('meta[name="csrf-token"]').attr('content')
