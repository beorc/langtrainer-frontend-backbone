describe "Langtrainer.LangtrainerApp.Views.CourseSelector", ->
  beforeEach ->
    worldData = getJSONFixture('world.json')
    world = new Langtrainer.LangtrainerApp.Models.World
    world.set(worldData)

    @view = new Langtrainer.LangtrainerApp.Views.CourseSelector(model: world)
    @view.render()

  it "should be a Backbone.View", ->
    expect(@view).toEqual(jasmine.any(Backbone.View))

  it "should render the selector markup", ->
    expect(@view.$('select')).toExist()

