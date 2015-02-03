class Langtrainer.LangtrainerApp.Views.Dialogs.SignIn extends Backbone.View
  _.extend(@prototype, Langtrainer.LangtrainerApp.Views.Extensions.Modal)

  template: JST['langtrainer_frontend_backbone/templates/dialogs/sign_in']
  id: 'dialog-sign-in'
  className: 'modal'

  events:
    'click .js-submit': 'onSubmitBtnClick'
    'click .sign-up-btn': 'onSignUpBtnClick'

  initialize: ->
    @model = new Langtrainer.LangtrainerApp.Models.User.Session
    @listenTo @model, 'error:unprocessable', @reRender, @
    @listenTo @model, 'invalid', @reRender, @

    Langtrainer.LangtrainerApp.globalBus.once 'user:signedIn', @onUserSignedIn, @

  renderForm: ->
    @$el.html(@template(model: @model))

  onSubmitBtnClick: ->
    @model.set('email', @$el.find('#email').val())
    @model.set('password', @$el.find('#password').val())
    @model.save()
    false

  onSignUpBtnClick: ->
    @$el.modal('hide')
    Langtrainer.LangtrainerApp.navigateToSignUp()
    false

  onUserSignedIn: ->
    @$el.modal('hide')

  onHiddenModal: ->
    Langtrainer.LangtrainerApp.globalBus.trigger('signInDialog:hidden')
    @remove()
