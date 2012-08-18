class Ideaspot.Routers.PollsRouter extends Backbone.Router
  initialize: (options) ->
    @polls = new Ideaspot.Collections.PollsCollection()
    @polls.reset options.polls

  routes:
    "new"      : "newPoll"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newPoll: ->
    @view = new Ideaspot.Views.Polls.NewView(collection: @polls)
    $("#polls").html(@view.render().el)

  index: ->
    @view = new Ideaspot.Views.Polls.IndexView(polls: @polls)
    $("#polls").html(@view.render().el)

  show: (id) ->
    poll = @polls.get(id)

    @view = new Ideaspot.Views.Polls.ShowView(model: poll)
    $("#polls").html(@view.render().el)

  edit: (id) ->
    poll = @polls.get(id)

    @view = new Ideaspot.Views.Polls.EditView(model: poll)
    $("#polls").html(@view.render().el)
