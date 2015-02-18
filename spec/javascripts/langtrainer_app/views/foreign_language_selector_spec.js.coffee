describe "Langtrainer.LangtrainerApp.Views.ForeignLanguageSelector", ->
  beforeEach ->
    Langtrainer.LangtrainerApp.clearCookies()

    worldData = getJSONFixture('world.json')
    @world = new Langtrainer.LangtrainerApp.Models.World
    Langtrainer.LangtrainerApp.currentUser = new Langtrainer.LangtrainerApp.Models.User
    @world.set(worldData)

    @view = new Langtrainer.LangtrainerApp.Views.ForeignLanguageSelector(
      collection: @world.getForeignLanguages('ru')
      model: Langtrainer.LangtrainerApp.currentUser.getCurrentForeignLanguage()
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
      Langtrainer.LangtrainerApp.globalBus.on('foreignLanguage:changed', context.onChange)

      select = @view.$('select')
      select
        .val('es')
        .change()
      select

    it 'should change current language slug', ->
      expect(@view.getCurrentLanguage().get('slug')).toEqual('es')

    it 'should trigger the event', ->
      expect(context.onChange).toHaveBeenCalled()

    it 'should change language_slug attribute in user', ->
      expect(Langtrainer.LangtrainerApp.currentUser.get('language_slug')).toEqual('es')
