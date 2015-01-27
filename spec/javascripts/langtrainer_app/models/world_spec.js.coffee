describe "Langtrainer.LangtrainerApp.Models.World", ->
  beforeEach ->
    worldData = getJSONFixture('world.json')
    @model = new Langtrainer.LangtrainerApp.Models.World
    @model.set(worldData)

  it "should be a Backbone.Model", ->
    expect(@model).toEqual(jasmine.any(Backbone.Model))

  it "should set up current course", ->
    expect(@model.get('course').get('slug')).toBeDefined()

  it "should set up current unit", ->
    expect(@model.get('unit').get('slug')).toBeDefined()

  it "should set up current step", ->
    expect(@model.get('step').get('id')).toBeDefined()

  it "should set up current language", ->
    expect(@model.get('language').get('slug')).toEqual('en')

  it "should set up current native language", ->
    expect(@model.get('nativeLanguage').get('slug')).toEqual('ru')
