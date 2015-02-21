describe "Langtrainer.LangtrainerApp.Views.NavbarControl", ->
  runApplication = ->
    worldData = getJSONFixture('world.json')
    window.Langtrainer.LangtrainerApp.run({})
    Langtrainer.LangtrainerApp.world.set(worldData)

  runApplication()

  beforeEach ->
    @view = new Langtrainer.LangtrainerApp.Views.NavbarControl
    @view.render()

  it "should be a Backbone.View", ->
    expect(@view).toEqual(jasmine.any(Backbone.View))

  describe 'given not signed in user', ->
    it 'should render sign in button', ->
      expect(@view.$('.sign-in-btn')).toExist()

    it 'should render sign up button', ->
      expect(@view.$('.sign-up-btn')).toExist()

    describe 'when user clicks sign in button', ->
      beforeEach ->
        @view.$('.sign-in-btn').click()

      it 'should show sign in dialog', ->
        expect($('#dialog-sign-in')).toExist()

    describe 'when user clicks sign up button', ->
      beforeEach ->
        @view.$('.sign-up-btn').click()

      it 'should show sign up dialog', ->
        expect($('#dialog-sign-up')).toExist()

  describe 'given signed in user', ->
    beforeEach ->
      window.Langtrainer.LangtrainerApp.currentUser.set('id', '1')
      window.Langtrainer.LangtrainerApp.currentUser.set('email', 'test@test.ru')
      window.Langtrainer.LangtrainerApp.currentUser.set('activation_state', 'active')
      @view.render()

    it 'should render sign out button', ->
      expect(@view.$('.sign-out-btn')).toExist()
