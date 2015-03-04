class Langtrainer.LangtrainerApp.Models.Course extends Backbone.Model
  _.extend(@prototype, Langtrainer.LangtrainerApp.Models.Extensions.HavingTitle)

  initialize: ->
    @set('unitsCollection', new Langtrainer.LangtrainerApp.Collections.Units(@get('units')))
    @listenTo @, 'change:units', @onUnitsChanged

    Langtrainer.LangtrainerApp.trainingBus.on 'unit:changed', @onUnitChanged, @

  onUnitsChanged: ->
    @get('unitsCollection').set(@get('units'))

  readAttribute: (attrName) ->
    @get(attrName) || $.cookie(attrName)

  getCurrentUnit: ->
    slug = @readAttribute('current_unit_slug')
    collection = @get('unitsCollection')

    result = null

    if slug?
      result = collection.findWhere(slug: slug)

    return result || collection.at(0)

  onUnitChanged: (unit) ->
    if @get('slug') == unit.get('course_slug')
      @set('current_unit_slug', unit.get('slug'))
