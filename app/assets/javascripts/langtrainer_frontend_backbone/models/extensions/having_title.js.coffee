Langtrainer.LangtrainerApp.Models.Extensions.HavingTitle =
  MAX_TITLE_LENGTH: 17

  title: ->
    _.string.capitalize(@get('slug')).replace(/_/g, ' ')

  truncatedTitle: ->
    title = @title()

    return title if title.length <= @MAX_TITLE_LENGTH

    jQuery
      .trim(title)
      .substring(0, @MAX_TITLE_LENGTH)
      .trim(@) + "..."
