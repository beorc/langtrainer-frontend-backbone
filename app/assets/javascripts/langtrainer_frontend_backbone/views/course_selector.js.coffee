class Langtrainer.LangtrainerApp.Views.CourseSelector extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/course_selector']
  id: 'course-selector'

  initialize: ->
    @listenTo @model, 'sync', @render

  render: ->
    if @model.get('courses').length > 0
      @$el.hide().html(@template(
        courses: @model.get('courses')
        model: @model.get('course')
      ))
      @$input = @.$('select')
      @$input.selectpicker(noneSelectedText: '')
      @$el.slideToggle()
    @
