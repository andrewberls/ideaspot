Ideaspot.Views.Ideas ||= {}

class Ideaspot.Views.Ideas.ShowCollection extends Backbone.View
  template: JST["backbone/templates/ideas/idea"]

  render: =>
    @$el.empty()
    @collection.each (idea) =>
      view = new Ideaspot.Views.Ideas.ShowView(model: idea)
      view = view.render()
      $(@el).append view

    return this


