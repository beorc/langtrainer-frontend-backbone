describe "Langtrainer.LangtrainerApp.Models.Step", ->
  beforeEach ->
    @model = new Langtrainer.LangtrainerApp.Models.Step

  it "should be a Backbone.Model", ->
    expect(@model).toEqual(jasmine.any(Backbone.Model))
