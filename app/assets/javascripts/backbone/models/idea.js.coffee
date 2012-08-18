class Ideaspot.Models.Idea extends Backbone.Model
  paramRoot: 'idea'
  url: "/ideas"

  defaults:
    title: "no title"
    votes: 0

class Ideaspot.Collections.IdeasCollection extends Backbone.Collection
  model: Ideaspot.Models.Idea

  url: ->
    "/polls/#{Ideaspot.get_poll_id()}/ideas"
