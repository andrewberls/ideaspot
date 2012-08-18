#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views

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

clearFormValues = ->
  $("#input-idea-username").val('')
  $("#input-idea-title").val('')

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
      newIdea.save({}, {
        success: (model, response) ->
          console.log "Success! Response:"
          console.log response
          clearFormValues()
          ideas.add response
      }, error: (model, error) ->
          console.log "Error:"
          console.log error
      )

$ ->
  Ideaspot.init()
