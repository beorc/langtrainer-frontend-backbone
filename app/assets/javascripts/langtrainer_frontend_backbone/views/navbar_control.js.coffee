class Langtrainer.LangtrainerApp.Views.NavbarControl extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/navbar_control']
  className: 'navbar-user-controls'

  events:
    'click .sign-in-btn': 'onSignInBtnClick'
    'click .sign-up-btn': 'onSignUpBtnClick'

  initialize: ->
    Langtrainer.LangtrainerApp.globalBus.once 'user:signedIn', @render, @

  render: ->
    @$el.html(@template())
    @

  onLoginBtnClick: ->
    Langtrainer.LangtrainerApp.navigateToSignIn()
    false

  onRegisterBtnClick: ->
    Langtrainer.LangtrainerApp.navigateToSignUp()
    false

  onSearchClick: ->
    term = $.trim(@$('input[name=q]').val())
    if term.length > 0
      @$('.search-form').submit()


