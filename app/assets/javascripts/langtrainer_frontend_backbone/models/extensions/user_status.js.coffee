Langtrainer.LangtrainerApp.Models.Extensions.UserStatus =
  handleUserStatus: (model, xhr, options)->
    @trigger 'error:not_activated' if xhr.status == 401
