describe "Langtrainer.LangtrainerApp.Collections.Units", ->
  beforeEach ->
    @collection = new Langtrainer.LangtrainerApp.Collections.Units

  it "should be a Backbone.Collection", ->
    expect(@collection).toEqual(jasmine.any(Backbone.Collection))


