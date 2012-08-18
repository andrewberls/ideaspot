Ideaspot.Views.Polls ||= {}

class Ideaspot.Views.Polls.NewView extends Backbone.View
  template: JST["backbone/templates/polls/new"]

  events:
    "submit #new-poll": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (poll) =>
        @model = poll
        window.location.hash = "/#{@model.id}"

      error: (poll, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
