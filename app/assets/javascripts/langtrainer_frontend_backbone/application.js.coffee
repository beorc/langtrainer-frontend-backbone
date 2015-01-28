#= require_self
#= require ./backbone_cors_patch
#= require_tree ./models/extensions
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./templates
#= require_tree ./views
#= require_tree ./routers

window.Langtrainer.LangtrainerApp =
  Models:
    Extensions: {}
  Collections: {}
  Views:
    Extensions: {}
  Routers: {}

  commonRouter: null
  world: null
  globalBus: _.extend({}, Backbone.Events)

  apiEndpoint: ''

  run: (initialData)->
    @apiEndpoint = initialData.apiEndpoint
    @currentUser = new Langtrainer.LangtrainerApp.Models.User(initialData.currentUser)

    @world = new Langtrainer.LangtrainerApp.Models.World(token: @currentUser.get('token'))
    @world.fetch()

    @commonRouter = new Langtrainer.LangtrainerApp.Routers.CommonRouter

    Backbone.history.start()

  navigate: (fragment, options)->
    scroll = $(window).scrollTop()

    @commonRouter.navigate(fragment, options)

    $(window).scrollTop(scroll)

  navigateRoot: ->
    @navigate('/')

  isUserLoggedIn: ->
    !!@currentUser.get('token')
