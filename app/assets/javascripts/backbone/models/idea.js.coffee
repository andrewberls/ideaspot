class Ideaspot.Models.Idea extends Backbone.Model
  paramRoot: 'idea'
  url: =>
    console.log "this context: " + this
    console.log this
    console.log "poll id: " + Ideaspot.get_poll_id()
    console.log "idea id: " + @get('id')
    console.log "Constructing show url: " +  "/polls/#{ Ideaspot.get_poll_id() }/ideas/#{ @get('id') }"
    "/polls/#{ Ideaspot.get_poll_id() }/ideas/"

  defaults:
    title: "no title"
    votes: 0

class Ideaspot.Collections.IdeasCollection extends Backbone.Collection
  model: Ideaspot.Models.Idea

  url: ->
    console.log "Constructing collection url: " + "/polls/#{ Ideaspot.get_poll_id() }/ideas"
    "/polls/#{ Ideaspot.get_poll_id() }/ideas"
