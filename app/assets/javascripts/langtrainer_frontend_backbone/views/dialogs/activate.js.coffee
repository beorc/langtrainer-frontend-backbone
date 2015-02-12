class Langtrainer.LangtrainerApp.Views.Activate extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/dialogs/activate']
  id: 'modal-activate'
  className: 'modal'

  events:
    'click .js-submit-btn': 'onSubmitBtnClick'
    'hidden.bs.modal': 'onHiddenModal'

  initialize: ->
    @model.on 'sync', @onSynced, @

  render: ->
    @$el.html(@template())
    @$el.modal('show')
    @

  onSubmitBtnClick: ->
    @$el.find('.alert.alert-success').hide()
    @model.save()
    false

  onSynced: ->
    @$el.find('.alert.alert-success').fadeIn()

  onHiddenModal: ->
    Langtrainer.LangtrainerApp.globalBus.trigger('activateDialog:hidden')
    @remove()
