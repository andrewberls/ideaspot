#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views

clearFormValues = ->
  $("#input-idea-username").val('')
  $("#input-idea-title").val('')

window.Ideaspot =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

  vote: (idea_id) ->
    $.cookie(Ideaspot.get_poll_id(), true)
    $.cookie(Ideaspot.get_poll_id() + "," + idea_id, true)

  withdrawVote: (idea_id) ->
    $.removeCookie(Ideaspot.get_poll_id() + "," + idea_id)
    $.removeCookie(Ideaspot.get_poll_id())

  hasVotedOn: (idea_id) ->
    $.cookie(Ideaspot.get_poll_id() + "," + idea_id) != null

  hasVoted: ->
    $.cookie(Ideaspot.get_poll_id()) != null

  get_poll_id: ->
    location.pathname.replace(/polls\//, '').slice(1).replace(/[^0-9]/g, '')

  init: ->
    id = Ideaspot.get_poll_id()
    ideas = new Ideaspot.Collections.IdeasCollection()
    ideas.fetch()

    @view = new Ideaspot.Views.Ideas.ShowCollection(collection: ideas, el: $("#ideas"))
    @view.render()

    $('#form-new-idea').submit ->
      username = $("#input-idea-username").val()
      title    = $("#input-idea-title").val()

      newIdea  = new Ideaspot.Models.Idea {
        title: title
        votes: 0
      }

      newIdea.save({ poll_id: Ideaspot.get_poll_id() }, {
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
