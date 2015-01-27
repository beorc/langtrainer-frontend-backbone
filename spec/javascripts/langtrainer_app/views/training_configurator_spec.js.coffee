describe "Langtrainer.LangtrainerApp.Views.TrainingConfigurator", ->
  beforeEach ->
    worldData = getJSONFixture('world.json')
    world = new Langtrainer.LangtrainerApp.Models.World(worldData)

    @view = new Langtrainer.LangtrainerApp.Views.TrainingConfigurator(world)
    @view.render()

  it "should be a Backbone.View", ->
    expect(@view).toEqual(jasmine.any(Backbone.View))
