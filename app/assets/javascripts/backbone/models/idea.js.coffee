class Ideaspot.Models.Idea extends Backbone.Model
  defaults:
    title: "no title" # TODO: this seems like a validation error
    votes: 0

  url: "/polls/#{ Ideaspot.get_poll_id() }/ideas/"


class Ideaspot.Collections.IdeasCollection extends Backbone.Collection
  model: Ideaspot.Models.Idea

  url: ->
    console.log "Constructing collection url: " + "/polls/#{ Ideaspot.get_poll_id() }/ideas"
    "/polls/#{ Ideaspot.get_poll_id() }/ideas"
