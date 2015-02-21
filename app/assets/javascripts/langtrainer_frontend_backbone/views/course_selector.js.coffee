class Langtrainer.LangtrainerApp.Views.CourseSelector extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/course_selector']
  id: 'course-selector'

  events:
    'change select': 'onChange'

  initialize: ->
    @listenTo @collection, 'change', @render
    @currentCourseSlug = @model.get('slug')

  render: ->
    that = @
    if @collection.length > 0
      @$el.html(@template(
        courses: @collection.models
        model: @getCurrentCourse()
        label: LangtrainerI18n.t('label.course')
      ))
      @$input = @.$('select')
      @$input.selectpicker(noneSelectedText: '')

    @

  getCurrentCourse: ->
    @collection.findWhere(slug: @currentCourseSlug)

  onChange: (ev) ->
    slug = $(ev.target).val()

    if slug != @currentCourseSlug
      @currentCourseSlug = slug
      Langtrainer.LangtrainerApp.trainingBus.trigger('course:changed', @getCurrentCourse())
