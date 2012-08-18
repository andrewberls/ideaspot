ConnectionView = Backbone.View.extend {
  template: _.template $("#template-socket-connection").html()

  events:
    'click .btn-primary': 'connect'
    'click .btn-danger' : 'disconnect'


  initialize: ->
    console.log "Socket view initialized. Attempting connection..."
    @model.on('change:connected', @render, @)
    @model.on 'socket:connect', (count) ->
      @model.set { count: count }
      @render()
    , @
    @model.connect()

  render: ->
    $(@el).html @template( @model.toJSON() )
    return @

  connect: ->
    @model.connect()

  disconnect: ->
    @model.disconnect()

}
