describe "Langtrainer.LangtrainerApp.Views.CourseSelector", ->
  beforeEach ->
    Langtrainer.LangtrainerApp.clearCookies()

    worldData = getJSONFixture('world.json')
    world = new Langtrainer.LangtrainerApp.Models.World
    Langtrainer.LangtrainerApp.currentUser = new Langtrainer.LangtrainerApp.Models.User
    world.set(worldData)

    @view = new Langtrainer.LangtrainerApp.Views.CourseSelector(
      collection: world.get('coursesCollection')
      model: Langtrainer.LangtrainerApp.currentUser.getCurrentCourse()
    )
    @view.render()

  it "should be a Backbone.View", ->
    expect(@view).toEqual(jasmine.any(Backbone.View))

  it "should render the selector markup", ->
    expect(@view.$('select')).toExist()

  describe 'when user selects another course', ->
    context = @
    context.onChange = ->
    beforeEach ->
      spyOn context, 'onChange'
      Langtrainer.LangtrainerApp.trainingBus.on('course:changed', context.onChange)

      select = @view.$('select')
      select
        .val('1')
        .change()
      select

    it 'should change current course slug', ->
      expect(@view.getCurrentCourse().get('slug')).toEqual('1')

    it 'should trigger event', ->
      expect(context.onChange).toHaveBeenCalled()

    it 'should change current_course_slug attribute in user', ->
      expect(Langtrainer.LangtrainerApp.currentUser.get('current_course_slug')).toEqual('1')
