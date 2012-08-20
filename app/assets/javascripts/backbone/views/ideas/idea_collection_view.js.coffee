Ideaspot.Views.Ideas ||= {}

class Ideaspot.Views.Ideas.ShowCollection extends Backbone.View
  template: JST["backbone/templates/ideas/idea"]

  initialize: ->
    @collection.on 'add', @addItem
    @collection.on 'reset', @render

  addItem: (idea) =>
    view = new Ideaspot.Views.Ideas.ShowView(model: idea)
    view = view.render() # What?
    @$el.append view

  render: =>
    @$el.empty()
    @collection.each (idea) =>
      @addItem idea

    return @


