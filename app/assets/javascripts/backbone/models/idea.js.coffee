class Ideaspot.Models.Idea extends Backbone.Model
  paramRoot: 'idea'

  defaults:
    title: "title default"
    votes: "votes default"

class Ideaspot.Collections.IdeasCollection extends Backbone.Collection
  model: Ideaspot.Models.Idea
  url: '/ideas'
