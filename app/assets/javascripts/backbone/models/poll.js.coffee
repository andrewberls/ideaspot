class Ideaspot.Models.Poll extends Backbone.Model
  paramRoot: 'poll'

  defaults:
    title: null

class Ideaspot.Collections.PollsCollection extends Backbone.Collection
  model: Ideaspot.Models.Poll
  url: '/polls'

