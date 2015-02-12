class Langtrainer.LangtrainerApp.Views.Dialogs.PasswordResetRequest extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/dialogs/password_reset_request']
  id: 'modal-password-reset-request'
  className: 'modal'

  events:
    'click .js-submit': 'onSubmitBtnClick'
    'click .sign-in-btn': 'onSignInBtnClick'
    'click .js-close': 'onCloseBtnClick'
    'hidden.bs.modal': 'onHiddenModal'

  initialize: ->
    @model = new Langtrainer.LangtrainerApp.Models.User.PasswordResetRequest

    @listenTo @model, 'error:unprocessable error:internal_server_error invalid', @renderForm, @
    @listenTo @model, 'synced', @onSynced, @

  render: ->
    @$el.html(@template())

    @$el.modal('show')

    @renderForm()

    @

  renderForm: ->
    form = JST['langtrainer_frontend_backbone/templates/dialogs/password_reset_request_form'](model: @model)
    @$('.modal-body > .step-a').html(form)

    @

  onSubmitBtnClick: ->
    @model.set('email', @$el.find('#email').val())
    @model.save()
    false

  onSignInBtnClick: ->
    @$el.one 'hidden.bs.modal', =>
      Langtrainer.LangtrainerApp.navigateToSignIn()

    @$el.modal('hide')
    false

  onSynced: ->
    @$('.step-a').hide()
    @$('.step-b').show()

  onHiddenModal: ->
    Langtrainer.LangtrainerApp.globalBus.trigger('passwordResetRequestDialog:hidden')
    @remove()

  onCloseBtnClick: ->
    $(@el).modal('hide')
