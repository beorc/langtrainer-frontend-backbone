class Langtrainer.LangtrainerApp.Views.NavbarControl extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/navbar_control']
  className: 'navbar-user-controls'

  events:
    'click .sign-in-btn': 'onSignInBtnClick'
    'click .sign-up-btn': 'onSignUpBtnClick'
    'click .sign-out-btn': 'onSignOutBtnClick'

  initialize: ->
    Langtrainer.LangtrainerApp.globalBus.once 'user:signedIn user:signdeOut', @render, @

  render: ->
    @$el.html(@template())
    @

  onSignInBtnClick: ->
    Langtrainer.LangtrainerApp.navigateToSignIn()
    false

  onSignUpBtnClick: ->
    Langtrainer.LangtrainerApp.navigateToSignUp()
    false

  onSignOutBtnClick: ->
    $.ajax
      url: '/api/users/sign_out'
      method: 'delete'
      dataType: 'json'
      success: ->
        Langtrainer.LangtrainerApp.globalBus.trigger('user:signedOut')
      error: ->
        alert('Oops... Something went wrong!')
    false
