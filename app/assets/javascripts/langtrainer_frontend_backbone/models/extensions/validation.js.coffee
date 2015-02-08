Langtrainer.LangtrainerApp.Models.Extensions.Validation =
  handleServerSideValidation: (model, xhr, options)->
    if xhr.status == 422
      @validationError = xhr.responseJSON.errors
      @trigger 'error:unprocessable'
    else if xhr.status == 500
      @clearValidationErrors()
      @pushValidationError(@validationError, 'serverError', LangtrainerI18n.t('error'))
      @trigger 'error:internal_server_error'

  clearValidationErrors: ->
    @validationError = {}

  validationErrorFor: (prop)->
    return null unless @validationError
    return null unless @validationError[prop]
    _.str.join(', ', @validationError[prop])

  pushValidationError: (errors, prop, str)->
    errors[prop] ||= []
    errors[prop].push str
    errors
