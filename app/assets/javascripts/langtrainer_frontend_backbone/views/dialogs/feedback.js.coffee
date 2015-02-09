class Langtrainer.LangtrainerApp.Views.Dialogs.Feedback extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/dialogs/feedback']
  id: 'dialog-feedback'
  className: 'modal'

  events:
    'click .js-submit': 'onSubmitBtnClick'
    'click .js-close': 'onCloseBtnClick'
    'hidden.bs.modal': 'onHiddenModal'

  initialize: (opts)->
    @model = new Langtrainer.LangtrainerApp.Models.Feedback
    @listenTo @model, 'error:unprocessable error:internal_server_error invalid', @renderForm, @
    @listenTo @model, 'sync', @onFeedbackCreated, @

  render: ->
    @$el.html(@template())

    @$el.modal('show')

    @renderForm()

    @

  renderForm: ->
    form = JST['langtrainer_frontend_backbone/templates/dialogs/feedback_form'](model: @model, view: @)
    @$('.modal-body > .step-a').html(form)

    @

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
