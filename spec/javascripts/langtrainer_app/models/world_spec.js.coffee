clearCookies = ->
  _.each $.cookie(), (value, key) ->
    $.removeCookie(key)

describe "Langtrainer.LangtrainerApp.Models.World", ->
  beforeEach ->
    clearCookies()
    worldData = getJSONFixture('world.json')
    @model = new Langtrainer.LangtrainerApp.Models.World
    Langtrainer.LangtrainerApp.currentUser = new Langtrainer.LangtrainerApp.Models.User
    @model.set(worldData)

  describe 'coursesCollection attribute', ->
    it "should be a Backbone.Collection", ->
      expect(@model.get('coursesCollection')).toEqual(jasmine.any(Backbone.Collection))

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
