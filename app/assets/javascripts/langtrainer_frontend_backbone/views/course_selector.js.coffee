class Langtrainer.LangtrainerApp.Views.CourseSelector extends Backbone.View
  _.extend(@prototype, Langtrainer.LangtrainerApp.Views.Extensions.Localized)

  template: JST['langtrainer_frontend_backbone/templates/course_selector']
  id: 'course-selector'

  events:
    'change select': 'onChange'

  initialize: ->
    @listenTo @collection, 'change', @render
    @initLocalization(onLocaleChanged: @render)

  render: ->
    that = @
    if @collection.length > 0
      @$el.html(@template(
        courses: @collection.models
        model: @model
        label: LangtrainerI18n.t('label.course')
      ))
      @$input = @.$('select')
      @$input.selectpicker(noneSelectedText: '')

    @

  onChange: (ev) ->
    slug = $(ev.target).val()

    if slug != @model.get('slug')
      @model.set @collection.findWhere(slug: slug).attributes
      Langtrainer.LangtrainerApp.currentUser.set('current_course_slug', slug)
      Langtrainer.LangtrainerApp.currentUser.persist()
