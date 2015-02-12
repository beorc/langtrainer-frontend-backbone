class Langtrainer.LangtrainerApp.Routers.CommonRouter extends Backbone.Router
  routes:
    'sign_in': 'signIn'
    'sign_up': 'signUp'
    'password_reset_request': 'passwordResetRequest'
    'feedback': 'feedback'

  signIn: ->
    modalView = new Langtrainer.LangtrainerApp.Views.Dialogs.SignIn
    modalView.render()

  signUp: ->
    modalView = new Langtrainer.LangtrainerApp.Views.Dialogs.SignUp
    modalView.render()

  passwordResetRequest: ->
    modalView = new Langtrainer.LangtrainerApp.Views.Dialogs.PasswordResetRequest
    modalView.render()

  feedback: ->
    modalView = new Langtrainer.LangtrainerApp.Views.Dialogs.Feedback
    modalView.render()
