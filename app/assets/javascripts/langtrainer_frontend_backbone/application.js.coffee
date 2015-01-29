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
  currentUser: null
  globalBus: _.extend({}, Backbone.Events)

  apiEndpoint: ''

  run: (initialData, successCallback, errorCallback)->
    @apiEndpoint = initialData.apiEndpoint
    @world = new Langtrainer.LangtrainerApp.Models.World
    @currentUser = new Langtrainer.LangtrainerApp.Models.User(model: initialData.currentUser)
    @world.attributes.token = @currentUser.readAttribute('token')

    @world.fetch(success: successCallback, error: errorCallback)

    @commonRouter = new Langtrainer.LangtrainerApp.Routers.CommonRouter

    Backbone.history.start()

  navigate: (fragment, options)->
    scroll = $(window).scrollTop()

    @commonRouter.navigate(fragment, options)

    $(window).scrollTop(scroll)

  navigateRoot: ->
    @navigate('/')
