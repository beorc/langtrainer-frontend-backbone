class Langtrainer.LangtrainerApp.Views.Dialogs.PasswordReset extends Backbone.View
  template: JST['langtrainer_frontend_backbone/templates/dialogs/password_reset']
  id: 'modal-password-reset'
  className: 'modal'

  events:
    'click .js-submit-btn': 'onSubmitBtnClick'
    'hidden.bs.modal': 'onHiddenModal'

  initialize: ->
    @model = new Langtrainer.LangtrainerApp.Models.User.PasswordReset
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
    Langtrainer.LangtrainerApp.globalBus.trigger('passwordResetDialog:hidden')
    @remove()
