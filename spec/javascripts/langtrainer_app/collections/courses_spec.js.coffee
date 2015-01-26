describe "Langtrainer.LangtrainerApp.Collections.Courses", ->
  beforeEach ->
    @collection = new Langtrainer.LangtrainerApp.Collections.Courses

  it "should be a Backbone.Collection", ->
    expect(@collection).toEqual(jasmine.any(Backbone.Collection))


