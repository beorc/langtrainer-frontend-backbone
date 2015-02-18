describe "Langtrainer.LangtrainerApp.Models.World", ->
  beforeEach ->
    Langtrainer.LangtrainerApp.clearCookies()
    worldData = getJSONFixture('world.json')
    @model = new Langtrainer.LangtrainerApp.Models.World
    Langtrainer.LangtrainerApp.currentUser = new Langtrainer.LangtrainerApp.Models.User
    @model.set(worldData)

  describe 'languagesCollection attribute', ->
    it "should be a Backbone.Collection", ->
      expect(@model.get('languagesCollection')).toEqual(jasmine.any(Backbone.Collection))

  describe 'coursesCollection attribute', ->
    it "should be a Backbone.Collection", ->
      expect(@model.get('coursesCollection')).toEqual(jasmine.any(Backbone.Collection))
