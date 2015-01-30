class Langtrainer.LangtrainerApp.Views.UnitSelector extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/unit_selector']
  id: 'unit-selector'

  initialize: ->
    @listenTo @collection, 'reset', @render

  render: ->
    that = @
    if @collection.length > 0
      @$el.hide().html(@template(
        units: @collection.models
        model: @model
      ))
      @$input = @.$('select')
      @$input.selectpicker(noneSelectedText: '')

      @$input.change (ev) -> that.onChange(ev)

      @$el.show()
    @

  onChange: (ev) ->
    slug = $(ev.target).val()

    if slug != @model.get('slug')
      @model.set('slug', slug)
