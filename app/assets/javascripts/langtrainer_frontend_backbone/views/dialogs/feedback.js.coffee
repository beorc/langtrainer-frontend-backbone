class Langtrainer.LangtrainerApp.Views.Dialogs.Feedback extends Backbone.View
  _.extend(@prototype, Langtrainer.LangtrainerApp.Views.Extensions.Modal)

  template: JST['langtrainer_frontend_backbone/templates/dialogs/feedback']
  id: 'dialog-feedback'
  className: 'modal'

  events:
    'click .js-submit': 'onSubmitBtnClick'
    'click .js-close': 'onCloseBtnClick'

  initialize: (opts)->
    @model = new Langtrainer.LangtrainerApp.Models.Feedback
    @listenTo @model, 'error:unprocessable error:internal_server_error invalid', @reRender, @
    @listenTo @model, 'sync', @onFeedbackCreated, @

  renderForm: ->
    $(@el).html(@template(model: @model, view: @))

  onSubmitBtnClick: ->
    @model.set('email', $.trim($(@el).find('#email').val()))
    @model.set('message', $(@el).find('#message').val())

    @model.save()
    false

  onCloseBtnClick: ->
    $(@el).modal('hide')

  onHiddenModal: ->
    Langtrainer.LangtrainerApp.globalBus.trigger('feedbackDialog:hidden')
    @remove()

  onFeedbackCreated: ->
    @$('.step-a').hide()
    @$('.step-b').show()

  buildClassFor: (attrName) ->
    result = ''

    if @model.validationErrorFor(attrName)
      result += 'has-error '

    if Langtrainer.LangtrainerApp.currentUser.signedIn() && Langtrainer.LangtrainerApp.currentUser.has(attrName)
      result += 'hide '

    result
