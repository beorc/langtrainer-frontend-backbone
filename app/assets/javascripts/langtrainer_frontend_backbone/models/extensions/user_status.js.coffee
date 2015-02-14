Langtrainer.LangtrainerApp.Models.Extensions.UserStatus =
  handleUserStatus: (model, xhr, options)->
    @trigger('error:not_activated', xhr.responseJSON.id) if xhr.status == 401
