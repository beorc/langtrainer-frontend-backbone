Langtrainer.LangtrainerApp.Models.Extensions.Csrf =
  initCsrf: ->
    @set(@csrfParam(), @csrfToken())
    Langtrainer.LangtrainerApp.globalBus.once 'csrfChanged', @initCsrf, @

  csrfParam: ->
    $('meta[name="csrf-param"]').attr('content')

  csrfToken: ->
    $('meta[name="csrf-token"]').attr('content')
