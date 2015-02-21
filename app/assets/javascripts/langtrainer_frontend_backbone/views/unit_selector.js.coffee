class Langtrainer.LangtrainerApp.Views.UnitSelector extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/unit_selector']
  id: 'unit-selector'

  events:
    'change select': 'onChange'

  initialize: ->
    Langtrainer.LangtrainerApp.trainingBus.on 'course:changed', @onCourseChanged, @
    @currentUnitSlug = @model.get('slug')

  render: ->
    that = @
    if @collection.length > 0
      @$el.hide().html(@template(
        units: @collection.models
        model: @getCurrentUnit()
        label: LangtrainerI18n.t('label.unit')
      ))
      @$input = @.$('select')
      @$input.selectpicker(noneSelectedText: '')

      @$el.show()
    @

  getCurrentUnit: ->
    @collection.findWhere(slug: @currentUnitSlug)

  onCourseChanged: (course) ->
    @collection = course.get('unitsCollection')
    @currentUnitSlug = course.getCurrentUnit().get('slug')
    @render()

  onChange: (ev) ->
    slug = $(ev.target).val()

    if slug != @currentUnitSlug
      @currentUnitSlug = slug
      Langtrainer.LangtrainerApp.trainingBus.trigger('unit:changed', @getCurrentUnit())
