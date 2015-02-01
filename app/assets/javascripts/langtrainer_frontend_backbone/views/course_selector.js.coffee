class Langtrainer.LangtrainerApp.Views.CourseSelector extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/course_selector']
  id: 'course-selector'

  events:
    'change select': 'onChange'

  initialize: ->
    @listenTo @collection, 'change', @render

  render: ->
    that = @
    if @collection.length > 0
      @$el.hide().html(@template(
        courses: @collection.models
        model: @model
        label: 'Course'
      ))
      @$input = @.$('select')
      @$input.selectpicker(noneSelectedText: '')

      @$el.slideToggle()
    @

  onChange: (ev) ->
    slug = $(ev.target).val()

    if slug != @model.get('slug')
      @model.set @collection.findWhere(slug: slug).attributes
