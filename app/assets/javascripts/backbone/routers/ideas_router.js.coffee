class Ideaspot.Routers.IdeasRouter extends Backbone.Router
  initialize: (options) ->
    @ideas = new Ideaspot.Collections.IdeasCollection()
    @ideas.reset options.ideas

  routes:
    "new"      : "newIdea"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newIdea: ->
    @view = new Ideaspot.Views.Ideas.NewView(collection: @ideas)
    $("#ideas").html(@view.render().el)

  index: ->
    @view = new Ideaspot.Views.Ideas.IndexView(ideas: @ideas)
    $("#ideas").html(@view.render().el)

  show: (id) ->
    idea = @ideas.get(id)

    @view = new Ideaspot.Views.Ideas.ShowView(model: idea)
    $("#ideas").html(@view.render().el)

  edit: (id) ->
    idea = @ideas.get(id)

    @view = new Ideaspot.Views.Ideas.EditView(model: idea)
    $("#ideas").html(@view.render().el)
