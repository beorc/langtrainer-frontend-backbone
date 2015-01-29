describe "Langtrainer.LangtrainerApp.Views.UnitSelector", ->
  beforeEach ->
    worldData = getJSONFixture('world.json')
    world = new Langtrainer.LangtrainerApp.Models.World
    world.set(worldData)

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
