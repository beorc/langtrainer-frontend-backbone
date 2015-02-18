describe "Langtrainer.LangtrainerApp.Views.UnitSelector", ->
  beforeEach ->
    Langtrainer.LangtrainerApp.clearCookies()

    worldData = getJSONFixture('world.json')
    world = new Langtrainer.LangtrainerApp.Models.World
    Langtrainer.LangtrainerApp.currentUser = new Langtrainer.LangtrainerApp.Models.User
    world.set(worldData)

    @course = world.get('course')
    @view = new Langtrainer.LangtrainerApp.Views.UnitSelector(
      collection: Langtrainer.LangtrainerApp.currentUser.getCurrentCourse().get('unitsCollection')
      model: Langtrainer.LangtrainerApp.currentUser.getCurrentCourse().getCurrentUnit()
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
      Langtrainer.LangtrainerApp.trainingBus.on('unit:changed', context.onChange)

      select = @view.$('select')
      select
        .val('1')
        .change()
      select

    it 'should change current unit slug', ->
      expect(@view.getCurrentUnit().get('slug')).toEqual('1')

    it 'should trigger the event', ->
      expect(context.onChange).toHaveBeenCalled()

    it 'should change current_unit_slug attribute in course', ->
      coursesCollection = Langtrainer.LangtrainerApp.world.get('coursesCollection')
      course = coursesCollection.findWhere(slug: @view.getCurrentUnit().get('course_slug'))
      expect(course.get('current_unit_slug')).toEqual('1')
