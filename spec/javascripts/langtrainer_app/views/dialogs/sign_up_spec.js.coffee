describe "Langtrainer.LangtrainerApp.Views.Dialogs.SignUp", ->
  clickSubmitButton = (view) ->
    view.$('.js-submit').click()

  beforeEach ->
    Langtrainer.LangtrainerApp.clearCookies()

    worldData = getJSONFixture('world.json')
    @world = new Langtrainer.LangtrainerApp.Models.World
    Langtrainer.LangtrainerApp.currentUser = new Langtrainer.LangtrainerApp.Models.User
    @world.set(worldData)

    @view = new Langtrainer.LangtrainerApp.Views.Dialogs.SignUp
    @view.renderForm()

  it "should be a Backbone.View", ->
    expect(@view).toEqual(jasmine.any(Backbone.View))

  it "should render markup", ->
    expect(@view.$('input#email')).toExist()
    expect(@view.$('input#password')).toExist()
    expect(@view.$('input#password_confirmation')).toExist()

  describe 'given an empty form', ->
    beforeEach ->
      spyOn @view.model, 'sync'
      clickSubmitButton(@view)

    it 'should not send request', ->
      expect(@view.model.sync).not.toHaveBeenCalled()

    it 'should render validation errors', ->
      expect(@view.$('.form-group.email.has-error p.help-block')).toExist()
      expect(@view.$('.form-group.password.has-error p.help-block')).toExist()
      expect(@view.$('.form-group.password-confirmation.has-error p.help-block')).toExist()

  describe 'given an empty email', ->
    beforeEach ->
      @view.$('#password').val('test password')
      @view.$('#password_confirmation').val('test password confirmation')
      spyOn @view.model, 'sync'
      clickSubmitButton(@view)

    it 'should not send request', ->
      expect(@view.model.sync).not.toHaveBeenCalled()

    it 'should render validation errors', ->
      expect(@view.$('.form-group.email.has-error p.help-block')).toExist()
      expect(@view.$('.form-group.password.has-error p.help-block')).not.toExist()
      expect(@view.$('.form-group.password-confirmation.has-error p.help-block')).not.toExist()

  describe 'given an empty password', ->
    beforeEach ->
      @view.$('#email').val('test@test.ru')
      @view.$('#password_confirmation').val('test password confirmation')
      spyOn @view.model, 'sync'
      clickSubmitButton(@view)

    it 'should not send request', ->
      expect(@view.model.sync).not.toHaveBeenCalled()

    it 'should render validation errors', ->
      expect(@view.$('.form-group.email.has-error p.help-block')).not.toExist()
      expect(@view.$('.form-group.password.has-error p.help-block')).toExist()
      expect(@view.$('.form-group.password-confirmation.has-error p.help-block')).not.toExist()

  describe 'given an empty password confirmation', ->
    beforeEach ->
      @view.$('#email').val('test@test.ru')
      @view.$('#password').val('test password')
      spyOn @view.model, 'sync'
      clickSubmitButton(@view)

    it 'should not send request', ->
      expect(@view.model.sync).not.toHaveBeenCalled()

    it 'should render validation errors', ->
      expect(@view.$('.form-group.email.has-error p.help-block')).not.toExist()
      expect(@view.$('.form-group.password.has-error p.help-block')).not.toExist()
      expect(@view.$('.form-group.password-confirmation.has-error p.help-block')).toExist()

  describe 'given an filled form', ->
    beforeEach ->
      @view.$('#email').val('test@test.ru')
      @view.$('#password').val('test password')
      @view.$('#password_confirmation').val('test password confirmation')
      spyOn @view.model, 'sync'
      clickSubmitButton(@view)

    it 'should not send request', ->
      expect(@view.model.sync).toHaveBeenCalled()

    it 'should render validation errors', ->
      expect(@view.$('.form-group.email.has-error p.help-block')).not.toExist()
      expect(@view.$('.form-group.password.has-error p.help-block')).not.toExist()
      expect(@view.$('.form-group.password-confirmation.has-error p.help-block')).not.toExist()
