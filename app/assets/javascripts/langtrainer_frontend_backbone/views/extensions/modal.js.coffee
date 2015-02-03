Langtrainer.LangtrainerApp.Views.Extensions.Modal =
  render: ->
    @bindModalEvents()
    @renderForm()
    $(@el).modal('show')
    @

  reRender: ->
    scroll = $(@el).scrollTop()

    @unbindModalEvents()
    $(@el).modal('hide')

    @bindModalEvents()
    @renderForm()

    $(@el).modal('show')

    $(@el).scrollTop(scroll)

    @

  bindModalEvents: ->
    $(@el).bind 'hidden.bs.modal', => @onHiddenModal()

  unbindModalEvents: ->
    $(@el).unbind 'hidden.bs.modal'
