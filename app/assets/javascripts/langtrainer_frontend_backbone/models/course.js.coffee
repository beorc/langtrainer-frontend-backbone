class Langtrainer.LangtrainerApp.Models.Course extends Backbone.Model
  initialize: ->
    @set('unitsCollection', new Langtrainer.LangtrainerApp.Collections.Units(@get('units')))
    @listenTo @, 'change:current_unit_slug', @onCurrentUnitSlugChanged
    @listenTo @, 'change:units', @onUnitsChanged
    @listenTo Langtrainer.LangtrainerApp.world, 'change:token', @onWorldChanged

  onWorldChanged: (world) ->
    @listenTo world.get('unit'), 'change:slug', @onUnitChanged

    @onUnitChanged(world.get('unit'))

  onCurrentUnitSlugChanged: ->
    $.cookie('current_unit_slug', @get('current_unit_slug'))

  onUnitsChanged: ->
    @get('unitsCollection').reset(@get('units'))

  title: ->
    _.string.capitalize @get('slug')

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
