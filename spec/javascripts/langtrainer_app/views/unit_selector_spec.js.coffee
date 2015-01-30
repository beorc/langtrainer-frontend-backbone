describe "Langtrainer.LangtrainerApp.Views.UnitSelector", ->
  beforeEach ->
    Langtrainer.LangtrainerApp.clearCookies()

    worldData = getJSONFixture('world.json')
    world = new Langtrainer.LangtrainerApp.Models.World
    Langtrainer.LangtrainerApp.currentUser = new Langtrainer.LangtrainerApp.Models.User
    world.set(worldData)

    @course = world.get('course')
    @view = new Langtrainer.LangtrainerApp.Views.UnitSelector(
      collection: world.get('course').get('unitsCollection')
      model: world.get('unit')
    )
    @view.render()

  it "should be a Backbone.View", ->
    expect(@view).toEqual(jasmine.any(Backbone.View))

  it "should render the selector markup", ->
    expect(@view.$('select')).toExist()

  describe 'when user selects another unit', ->
    context = @
    context.onChange = ->
    beforeEach ->
      spyOn context, 'onChange'
      @view.model.on('change:slug', context.onChange)

      select = @view.$('select')
      select
        .val('1')
        .change()
      select

    it 'should change current unit slug', ->
      expect(@view.model.get('slug')).toEqual('1')

    it 'should trigger event change:slug for current unit model', ->
      expect(context.onChange).toHaveBeenCalled()

    it 'should change current_unit_slug attribute in course', ->
      expect(@course.get('current_unit_slug')).toEqual(@view.model.get('slug'))
