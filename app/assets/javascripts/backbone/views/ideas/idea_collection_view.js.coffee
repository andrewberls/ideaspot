Ideaspot.Views.Ideas ||= {}

class Ideaspot.Views.Ideas.ShowCollection extends Backbone.View
  template: JST["backbone/templates/ideas/idea"]

  initialize: ->
    @collection.on 'add', @addItem


  addItem: (idea) =>
    view = new Ideaspot.Views.Ideas.ShowView(model: idea)
    view = view.render()
    @$el.append view

  render: =>
    @$el.empty()
    @collection.each (idea) =>
      @addItem idea

    return this


