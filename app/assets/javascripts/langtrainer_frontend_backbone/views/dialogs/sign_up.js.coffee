class Langtrainer.LangtrainerApp.Views.Dialogs.SignUp extends Backbone.View
  _.extend(@prototype, Langtrainer.LangtrainerApp.Views.Extensions.Modal)

  template: JST['langtrainer_frontend_backbone/templates/dialogs/sign_up']
  id: 'dialog-sign-up'
  className: 'modal'

  events:
    'click .js-submit': 'onSubmitBtnClick'
    'click .sign-in-btn': 'onSignInBtnClick'

  initialize: (options) ->
    @model = new Langtrainer.LangtrainerApp.Models.User.Registration
    @model.set('authenticity_token', Langtrainer.LangtrainerApp.csrfToken)

    @listenTo @model, 'error:unprocessable error:internal_server_error', @reRender, @
    @listenTo @model, 'invalid', @reRender, @

    Langtrainer.LangtrainerApp.globalBus.once 'user:signedUp', @onUserSignedUp, @

  renderForm: (options = {}) ->
    @$el.html(@template(model: @model))

    @

  onSubmitBtnClick: ->
    @model.set('email', $.trim(@$el.find('#email').val()))
    @model.set('password', $.trim(@$el.find('#password').val()))
    @model.set('password_confirmation', $.trim(@$el.find('#password_confirmation').val()))

    @model.save()
    false

  onUserSignedUp: ->
    @$el.modal('hide')

  onHiddenModal: ->
    Langtrainer.LangtrainerApp.globalBus.trigger('signUpDialog:hidden')
    @remove()

  onSignInBtnClick: ->
    @$el.modal('hide')
    Langtrainer.LangtrainerApp.navigateToSignIn()
    false
