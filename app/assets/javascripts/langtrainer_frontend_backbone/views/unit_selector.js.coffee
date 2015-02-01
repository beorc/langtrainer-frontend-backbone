class Langtrainer.LangtrainerApp.Views.UnitSelector extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/unit_selector']
  id: 'unit-selector'

  events:
    'change select': 'onChange'

  initialize: ->
    @listenTo @collection, 'reset', @render

  render: ->
    that = @
    if @collection.length > 0
      @$el.hide().html(@template(
        units: @collection.models
        model: @model
        label: 'Unit'
      ))
      @$input = @.$('select')
      @$input.selectpicker(noneSelectedText: '')

      @$el.show()
    @

  onChange: (ev) ->
    slug = $(ev.target).val()

    if slug != @model.get('slug')
      @model.set('slug', slug)
