describe "Langtrainer.LangtrainerApp.Views.StepView", ->
  beforeEach ->
    worldData = getJSONFixture('world.json')
    world = new Langtrainer.LangtrainerApp.Models.World(worldData)

    @view = new Langtrainer.LangtrainerApp.Views.StepView(world.get('courses')[0].units[0].current_step)
    @view.render()

  it "should be a Backbone.View", ->
    expect(@view).toEqual(jasmine.any(Backbone.View))
