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
  Views: {}

  get_poll_id: ->
    location.pathname.replace(/polls\//, '').slice(1).replace(/[^0-9]/g, '')

  init: ->
    id = Ideaspot.get_poll_id()
    ideas = new Ideaspot.Collections.IdeasCollection()
    ideas.fetch()

    # What is going on here
    @view = new Ideaspot.Views.Ideas.ShowCollection(
      collection: ideas,
      el: $("#ideas")
    )
    @view.render()

    $('#new-idea-form').submit ->
      username = $("#input-idea-username").val()
      title    = $("#input-idea-title").val()

      idea  = new Ideaspot.Models.Idea {
        title: title
        votes: 0
      }

      idea.save({ poll_id: Ideaspot.get_poll_id() }, {
        success: (model, response) ->
          console.log "Success! Response:"
          console.log response
          clearFormValues()
          ideas.add response
      , error: (model, error) ->
          console.log "Error:"
          console.log error
      });



Ideaspot.User =
  # TODO: can vote and withdrawVote use hasVotedOn to
  # combine into toggle()?
  vote: (idea_id) ->
    console.log @
    $.cookie(Ideaspot.get_poll_id(), true)
    $.cookie(Ideaspot.get_poll_id() + "-" + idea_id, true)

  withdrawVote: (idea_id) ->
    $.removeCookie(Ideaspot.get_poll_id() + "-" + idea_id)
    $.removeCookie(Ideaspot.get_poll_id())

  hasVotedOn: (idea_id) ->
    $.cookie(Ideaspot.get_poll_id() + "," + idea_id) != null

  hasVoted: ->
    $.cookie(Ideaspot.get_poll_id()) != null


$ ->
  Ideaspot.init()
