class Langtrainer.LangtrainerApp.Views.Dialogs.SignIn extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/dialogs/sign_in']
  id: 'dialog-sign-in'
  className: 'modal'

  events:
    'click .js-submit': 'onSubmitBtnClick'
    'click .sign-up-btn': 'onSignUpBtnClick'
    'click .password-reset-request-btn': 'showPasswordResetRequestDialog'
    'click .js-close': 'onCloseBtnClick'
    'hidden.bs.modal': 'onHiddenModal'

  initialize: ->
    @model = new Langtrainer.LangtrainerApp.Models.User.Session

    @listenTo @model, 'error:unprocessable error:internal_server_error invalid', @renderForm, @
    @listenTo @model, 'error:not_activated', @showActivateDialog, @

    Langtrainer.LangtrainerApp.globalBus.on 'user:signedIn', @onUserSignedIn, @

  render: ->
    @$el.html(@template())

    @$el.modal('show')

    @renderForm()

    @

  renderForm: ->
    form = JST['langtrainer_frontend_backbone/templates/dialogs/sign_in_form'](model: @model)
    @$('.modal-body > .step-a').html(form)

    @

  onSubmitBtnClick: ->
    @model.set('email', @$el.find('#email').val())
    @model.set('password', @$el.find('#password').val())
    @model.save()
    false

  onSignUpBtnClick: ->
    @$el.one 'hidden.bs.modal', =>
      Langtrainer.LangtrainerApp.navigateToSignUp()

    @$el.modal('hide')
    false

  onUserSignedIn: ->
    @$('.step-a').hide()
    @$('.step-b').show()

  onHiddenModal: ->
    Langtrainer.LangtrainerApp.globalBus.trigger('signInDialog:hidden')
    @remove()

  onCloseBtnClick: ->
    $(@el).modal('hide')

  showActivateDialog: (id) ->
    @$el.one 'hidden.bs.modal', ->
      Langtrainer.LangtrainerApp.showActivateDialog(id)

    @$el.modal('hide')

  showPasswordResetRequestDialog: ->
    @$el.one 'hidden.bs.modal', =>
      Langtrainer.LangtrainerApp.navigateToPasswordResetRequest()

    @$el.modal('hide')
