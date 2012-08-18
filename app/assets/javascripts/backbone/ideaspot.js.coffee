#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Ideaspot =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: ->
    new Ideaspot.Routers.PollsRouter
    Backbone.history.start()
    console.log 'init done'

$(->
  polls = {

  }
  Ideaspot.init(polls)
)
