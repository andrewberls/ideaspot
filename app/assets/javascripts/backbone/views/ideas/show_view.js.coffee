Ideaspot.Views.Ideas ||= {}

class Ideaspot.Views.Ideas.ShowView extends Backbone.View
  template: JST["backbone/templates/ideas/idea"]

  render: ->
    $(@el).html(@template(@model.toJSON()))
    #    return this
    return @template(@model.toJSON())
