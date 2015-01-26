describe "Langtrainer.LangtrainerApp.Models.User", ->
  beforeEach ->
    @model = new Langtrainer.LangtrainerApp.Models.User()

  it "should be a Backbone.Model", ->
    expect(@model).toEqual(jasmine.any(Backbone.Model))
