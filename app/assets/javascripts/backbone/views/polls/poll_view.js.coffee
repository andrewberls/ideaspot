Ideaspot.Views.Polls ||= {}

class Ideaspot.Views.Polls.PollView extends Backbone.View
  template: JST["backbone/templates/polls/poll"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
