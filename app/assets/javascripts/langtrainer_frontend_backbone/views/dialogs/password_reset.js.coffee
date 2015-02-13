class Langtrainer.LangtrainerApp.Views.Dialogs.PasswordReset extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/dialogs/password_reset']
  id: 'modal-password-reset'
  className: 'modal'

  events:
    'click .js-submit': 'onSubmitBtnClick'
    'click .sign-in-btn': 'onSignInBtnClick'
    'click .js-close': 'onCloseBtnClick'
    'hidden.bs.modal': 'onHiddenModal'

  initialize: ->
    @listenTo @model, 'error:unprocessable error:internal_server_error invalid', @renderForm, @
    @listenTo @model, 'sync', @onSynced, @

  render: ->
    @$el.html(@template())

    @$el.modal('show')

    @renderForm()

    @

  renderForm: ->
    form = JST['langtrainer_frontend_backbone/templates/dialogs/password_reset_form'](model: @model)
    @$('.modal-body > .step-a').html(form)

    @

  onSubmitBtnClick: ->
    @model.set('password', $.trim(@$el.find('#password').val()))
    @model.set('password_confirmation', $.trim(@$el.find('#password_confirmation').val()))
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
    Langtrainer.LangtrainerApp.globalBus.trigger('passwordResetDialog:hidden')
    @remove()

  onCloseBtnClick: ->
    $(@el).modal('hide')
