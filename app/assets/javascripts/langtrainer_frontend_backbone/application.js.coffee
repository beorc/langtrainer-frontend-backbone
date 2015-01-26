#= require_self
#= require_tree ./models/extensions
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./templates
#= require_tree ./views
#= require_tree ./routers

window.Langtrainer.LangtrainerApp =
  Models:
    Extensions: {}
    User: {}
  Collections:
    User: {}
  Views:
    Extensions: {}
    Comments: {}
    User: {}
  Routers: {}

  commonRouter: null
  currentUser: null
  globalBus: _.extend({}, Backbone.Events)

  apiEndpoint: 'https://langtrainer-api-rails.herokuapp.com'
  backendEndpoint: 'https://langtrainer-backend.herokuapp.com'

  run: (initialData)->
    # Инициализация состояния приложения
    if initialData.current_user
      @setupCurrentUser(initialData.current_user)

    # Роутинг
    @commonRouter = new Langtrainer.LangtrainerApp.Routers.CommonRouter

    Backbone.history.start()

  navigate: (fragment, options)->
    scroll = $(window).scrollTop()

    @commonRouter.navigate(fragment, options)

    $(window).scrollTop(scroll)

  navigateRoot: ->
    @navigate('/')

  setupCurrentUser: (attrs)->
    @currentUser = new Langtrainer.LangtrainerApp.Models.User(attrs)

  isUserLoggedIn: ->
    !!@currentUser
