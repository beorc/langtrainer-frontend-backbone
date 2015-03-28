Langtrainer.LangtrainerApp.Models.Extensions.Validation =
  handleServerSideValidation: (model, xhr, options)->
    if xhr.status == 422
      if xhr.responseText == 'invalid token'
        token = $.cookie()['X-CSRF-Token']
        $('meta[name="csrf-token"]').attr('content', token)

        if model.get('retryWithNewCSRFToken')
          @clearValidationErrors()
          @pushValidationError(@validationError, 'serverError', 'При выполнении операции возникла непредвиденная ошибка')
          @trigger 'error:unprocessable'
        else
          model.set('retryWithNewCSRFToken', true)
          model.save()
      else
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
