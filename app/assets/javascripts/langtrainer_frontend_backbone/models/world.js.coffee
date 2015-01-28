class Langtrainer.LangtrainerApp.Models.World extends Backbone.Model
  url: -> Langtrainer.LangtrainerApp.apiEndpoint + '/world?token=' + @token

  initialize: ->
    @set('course', new Langtrainer.LangtrainerApp.Models.Course)
    @set('unit', new Langtrainer.LangtrainerApp.Models.Unit)
    @set('step', new Langtrainer.LangtrainerApp.Models.Step)
    @set('language', new Langtrainer.LangtrainerApp.Models.Language)
    @set('nativeLanguage', new Langtrainer.LangtrainerApp.Models.Language)

    @listenTo @, 'sync change', @reset

  reset: ->
    course = @get('course')
    unit = @get('unit')
    step = @get('step')

    course.set @get('courses')[0]
    unit.set course.get('units')[0]
    step.set unit.get('current_step')

    @get('language').set @get('languages')[0]
    @get('nativeLanguage').set @get('languages')[1]
