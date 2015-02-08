Langtrainer.LangtrainerApp.Models.Extensions.Csrf =
  initCsrf: ->
    @resetCsrf()
    Langtrainer.LangtrainerApp.globalBus.on 'csrfChanged', @resetCsrf, @

  resetCsrf: ->
    @set(@csrfParam(), @csrfToken())

  csrfParam: ->
    $('meta[name="csrf-param"]').attr('content')

  csrfToken: ->
    $('meta[name="csrf-token"]').attr('content')
