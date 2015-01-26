describe "Langtrainer.LangtrainerApp.Models.Unit", ->
  beforeEach ->
    @model = new Langtrainer.LangtrainerApp.Models.Unit

  it "should be a Backbone.Model", ->
    expect(@model).toEqual(jasmine.any(Backbone.Model))
