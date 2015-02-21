describe "Langtrainer.LangtrainerApp.Views.NativeLanguageSelector", ->
  beforeEach ->
    Langtrainer.LangtrainerApp.clearCookies()

    worldData = getJSONFixture('world.json')

    Langtrainer.LangtrainerApp.run()
    Langtrainer.LangtrainerApp.world.set(worldData)

    @view = new Langtrainer.LangtrainerApp.Views.NativeLanguageSelector(
      collection: Langtrainer.LangtrainerApp.world.get('languagesCollection')
      model: Langtrainer.LangtrainerApp.currentUser.getCurrentNativeLanguage()
    )
    @view.render()

  it "should be a Backbone.View", ->
    expect(@view).toEqual(jasmine.any(Backbone.View))

  it "should render the selector markup", ->
    expect(@view.$('select')).toExist()

  describe 'when user selects another language', ->
    context = @
    context.onChange = ->
    beforeEach ->
      spyOn context, 'onChange'
      Langtrainer.LangtrainerApp.globalBus.on('nativeLanguage:changed', context.onChange)

      select = @view.$('select')
      select
        .val('en')
        .change()
      select

    it 'should change current native language slug', ->
      expect(@view.getCurrentLanguage().get('slug')).toEqual('en')

    it 'should trigger the event', ->
      expect(context.onChange).toHaveBeenCalled()

    it 'should change native_language_slug attribute in user', ->
      expect(Langtrainer.LangtrainerApp.currentUser.get('native_language_slug')).toEqual('en')
