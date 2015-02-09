class Langtrainer.LangtrainerApp.Views.Dialogs.SignUp extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/dialogs/sign_up']
  id: 'dialog-sign-up'
  className: 'modal'

  events:
    'click .js-submit': 'onSubmitBtnClick'
    'click .sign-in-btn': 'onSignInBtnClick'
    'click .js-close': 'onCloseBtnClick'
    'hidden.bs.modal': 'onHiddenModal'

  initialize: (options) ->
    @model = new Langtrainer.LangtrainerApp.Models.User.Registration

    @listenTo @model, 'error:unprocessable error:internal_server_error invalid', @renderForm, @

    Langtrainer.LangtrainerApp.globalBus.on 'user:signedUp', @onUserSignedUp, @

  render: ->
    @$el.html(@template())

    @$el.modal('show')

    @renderForm()

    @

  renderForm: ->
    form = JST['langtrainer_frontend_backbone/templates/dialogs/sign_up_form'](model: @model)
    @$('.modal-body > .step-a').html(form)

    @

  onSubmitBtnClick: ->
    @model.set('email', $.trim(@$el.find('#email').val()))
    @model.set('password', $.trim(@$el.find('#password').val()))
    @model.set('password_confirmation', $.trim(@$el.find('#password_confirmation').val()))

    @model.save()
    false

  onUserSignedUp: ->
    @$('.step-a').hide()
    @$('.step-b').show()

  onHiddenModal: ->
    Langtrainer.LangtrainerApp.globalBus.trigger('signUpDialog:hidden')
    @remove()

  onSignInBtnClick: ->
    @$el.modal('hide')
    Langtrainer.LangtrainerApp.navigateToSignIn()
    false

  onCloseBtnClick: ->
    $(@el).modal('hide')
