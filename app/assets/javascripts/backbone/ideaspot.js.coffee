#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

sample_data = [
  [
    {
    title: "Gio's"
    votes : 2
    }
    {
    title: "Rusty's"
    votes : 1
    }
  ]
  [
    {
    title: "Monadnock Sugarhouse"
    votes : 1
    }
    {
    title: "Aunt Jemima"
    votes : 6
    }
    {
    title: "The Maple Guys"
    votes : 3
    }
  ]
]


window.Ideaspot =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  get_poll_id: ->
    location.pathname.replace(/polls\//, '').slice(1)

  init: ->
    id = Ideaspot.get_poll_id()
    # TODO replace stub with real code
    ideas = new Ideaspot.Collections.IdeasCollection()
    ideas.reset sample_data[Ideaspot.get_poll_id() - 1]
    # poll = @polls.get(id)

    @view = new Ideaspot.Views.Ideas.ShowCollection(collection: ideas, el: $("#ideas"))
    @view.render()
    $('#form-new-idea').submit ->
      username = $("#input-idea-username").val()
      title = $("#input-idea-title").val()
      newIdea = new Ideaspot.Models.Idea {
        title: title
        votes: 0
      }
      console.log "newIdea"
      console.log newIdea
      newIdea.save(
        success: (model, response) ->
          console.log "model"
          console.log model
          console.log "response"
          console.log response
      )

$ ->
  Ideaspot.init()
