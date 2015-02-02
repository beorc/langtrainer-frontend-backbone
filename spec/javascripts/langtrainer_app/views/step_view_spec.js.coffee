describe "Langtrainer.LangtrainerApp.Views.StepView", ->
  beforeEach ->
    worldData = getJSONFixture('world.json')
    world = new Langtrainer.LangtrainerApp.Models.World
    Langtrainer.LangtrainerApp.currentUser = new Langtrainer.LangtrainerApp.Models.User
    world.set(worldData)

    @view = new Langtrainer.LangtrainerApp.Views.StepView(model: world.get('step'))
    @view.render()

  it "should be a Backbone.View", ->
    expect(@view).toEqual(jasmine.any(Backbone.View))
