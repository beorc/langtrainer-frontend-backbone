describe "Langtrainer.LangtrainerApp.Models.User", ->
  beforeEach ->
    worldData = getJSONFixture('world.json')
    Langtrainer.LangtrainerApp.world = new Langtrainer.LangtrainerApp.Models.World(model: worldData)
    @model = new Langtrainer.LangtrainerApp.Models.User

  it "should be a Backbone.Model", ->
    expect(@model).toEqual(jasmine.any(Backbone.Model))

  describe 'given not signed in user', ->
    beforeEach ->
      $.cookie('token', 'cookie-token')

    describe 'when token changes', ->
      beforeEach ->
        spyOn @model, 'save'
        @model.set('token', 'new-token')

      it 'should store token to the cookie', ->
        expect($.cookie('token')).toEqual('new-token')

      it 'should not save model', ->
        expect(@model.save).not.toHaveBeenCalled()

    describe "#readAttribute('token')", ->
      it 'should return token from cookie', ->
        expect(@model.readAttribute('token')).toEqual('cookie-token')

  describe 'given signed in user', ->
    beforeEach ->
      @model.set('email', 'test@test.ru')

    describe 'when token changes', ->
      beforeEach ->
        spyOn @model, 'save'
        @model.set('token', 'model-token')

      it 'should save model', ->
        expect(@model.save).toHaveBeenCalled()

      describe "#readAttribute('token')", ->
        it 'should return token from model', ->
          expect(@model.readAttribute('token')).toEqual('model-token')
