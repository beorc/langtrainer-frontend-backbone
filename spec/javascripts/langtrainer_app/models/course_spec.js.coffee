describe "Langtrainer.LangtrainerApp.Models.Course", ->
  beforeEach ->
    @model = new Langtrainer.LangtrainerApp.Models.Course

  it "should be a Backbone.Model", ->
    expect(@model).toEqual(jasmine.any(Backbone.Model))
