class Langtrainer.LangtrainerApp.Routers.CommonRouter extends Backbone.Router
  routes:
    'login': 'login'
    'register': 'register'
    'feedback': 'feedback'

  login: ->
    modalView = new Langtrainer.LangtrainerApp.Views.LoginPopup
    modalView.render()

  register: ->
    modalView = new Langtrainer.LangtrainerApp.Views.RegisterPopup
    modalView.render()

  feedback: ->
    modalView = new Langtrainer.LangtrainerApp.Views.FeedbackPopup
    modalView.render()
