Langtrainer.LangtrainerApp.Models.Extensions.HavingTitle =
  title: ->
    _.string.capitalize(@get('slug')).replace(/_/g, ' ')

  truncatedTitle: (maxTitleLength = 17)->
    title = @title()

    return title if title.length <= maxTitleLength

    jQuery
      .trim(title)
      .substring(0, maxTitleLength)
      .trim(@) + "..."
