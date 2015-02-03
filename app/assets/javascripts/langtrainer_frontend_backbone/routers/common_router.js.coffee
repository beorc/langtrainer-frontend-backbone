class Langtrainer.LangtrainerApp.Routers.CommonRouter extends Backbone.Router
  routes:
    'sign_in': 'sign_in'
    'sign_up': 'sign_up'
    'feedback': 'feedback'

  sign_in: ->
    modalView = new Langtrainer.LangtrainerApp.Views.Dialogs.SignIn
    modalView.render()

  sign_up: ->
    modalView = new Langtrainer.LangtrainerApp.Views.Dialogs.SignUp
    modalView.render()

  feedback: ->
    modalView = new Langtrainer.LangtrainerApp.Views.Dialogs.Feedback
    modalView.render()
