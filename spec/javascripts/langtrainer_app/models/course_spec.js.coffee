describe "Langtrainer.LangtrainerApp.Models.Course", ->
  beforeEach ->
    worldData = getJSONFixture('world.json')
    Langtrainer.LangtrainerApp.world = new Langtrainer.LangtrainerApp.Models.World(model: worldData)
    units = worldData.courses[0].units
    @model = new Langtrainer.LangtrainerApp.Models.Course(slug: 'test')
    @model.set('units', units)

  it "should be a Backbone.Model", ->
    expect(@model).toEqual(jasmine.any(Backbone.Model))

  describe 'unitsCollection attribute', ->
    it "should be a Backbone.Collection", ->
      expect(@model.get('unitsCollection')).toEqual(jasmine.any(Backbone.Collection))

  describe '#title', ->
    it 'should return capitalized slug', ->
      expect(@model.title()).toEqual('Test')
