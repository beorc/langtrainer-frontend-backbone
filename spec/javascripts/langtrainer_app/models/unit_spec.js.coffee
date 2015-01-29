describe "Langtrainer.LangtrainerApp.Models.Unit", ->
  beforeEach ->
    @model = new Langtrainer.LangtrainerApp.Models.Unit(slug: 'test')

  it "should be a Backbone.Model", ->
    expect(@model).toEqual(jasmine.any(Backbone.Model))

  describe '#title', ->
    it 'should return capitalized slug', ->
      expect(@model.title()).toEqual('Test')
