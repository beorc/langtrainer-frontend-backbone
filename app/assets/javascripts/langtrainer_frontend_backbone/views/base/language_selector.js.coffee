class Langtrainer.LangtrainerApp.Views.LanguageSelector extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/language_selector']
  class: 'language-selector'

  events:
    'change select': 'onChange'

  initialize: (options) ->
    @options = options
    @currentLanguageSlug = @model.get('slug')

  render: ->
    that = @
    if @collection.length > 0
      @$el.hide().html(@template(
        languages: @collection.models
        model: @getCurrentLanguage()
        label: LangtrainerI18n.t('label.' + @options.label)
      ))
      @$input = @.$('select')
      @$input.selectpicker(noneSelectedText: '')

      @$el.show()
    @

  getCurrentLanguage: ->
    @collection.findWhere(slug: @currentLanguageSlug)
