class Langtrainer.LangtrainerApp.Models.World extends Backbone.Model
  urlRoot: "#{Langtrainer.LangtrainerApp.apiEndpoint}/world"
  url: -> @urlRoot + '?token=' + @token
