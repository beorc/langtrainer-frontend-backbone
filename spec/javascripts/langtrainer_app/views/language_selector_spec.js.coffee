describe "Langtrainer.LangtrainerApp.Views.LanguageSelector", ->
  beforeEach ->
    Langtrainer.LangtrainerApp.clearCookies()

    worldData = getJSONFixture('world.json')
    @world = new Langtrainer.LangtrainerApp.Models.World
    Langtrainer.LangtrainerApp.currentUser = new Langtrainer.LangtrainerApp.Models.User
    @world.set(worldData)

  describe 'given native languages collection', ->
    beforeEach ->
      @view = new Langtrainer.LangtrainerApp.Views.LanguageSelector(
        collection: @world.get('nativeLanguagesCollection')
        model: @world.get('nativeLanguage')
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
        @view.model.on('change:slug', context.onChange)

        select = @view.$('select')
        select
          .val('en')
          .change()
        select

      it 'should change current native language slug', ->
        expect(@view.model.get('slug')).toEqual('en')

      it 'should trigger event change:slug for current course model', ->
        expect(context.onChange).toHaveBeenCalled()

      it 'should change native_language_slug attribute in user', ->
        expect(Langtrainer.LangtrainerApp.currentUser.get('native_language_slug')).toEqual(@view.model.get('slug'))

  describe 'given languages collection', ->
    beforeEach ->
      @view = new Langtrainer.LangtrainerApp.Views.LanguageSelector(
        collection: @world.get('languagesCollection')
        model: @world.get('language')
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
        @view.model.on('change:slug', context.onChange)

        select = @view.$('select')
        select
          .val('es')
          .change()
        select

      it 'should change current language slug', ->
        expect(@view.model.get('slug')).toEqual('es')

      it 'should trigger event change:slug for current course model', ->
        expect(context.onChange).toHaveBeenCalled()

      it 'should change language_slug attribute in user', ->
        expect(Langtrainer.LangtrainerApp.currentUser.get('language_slug')).toEqual(@view.model.get('slug'))
