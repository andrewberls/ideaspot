SocketWrapper = Backbone.Model.extend {
  defaults:
    connected: false
    count: 0

  connect: ->
    return if window.socket && socket.readyState == 1 # Already connected

    url = "ws://#{@get('host')}:#{@get('port')}"
    console.log "Connecting to #{url}"

    window.socket = new WebSocket(url)
    @set { connected : true }

    socket.onmessage = (msg) =>
      try
        response = JSON.parse(msg.data)
      catch ex
        @trigger('socket:parse_error', "Could not parse socket msg: #{msg.data}")

      if response.type == 'Connect'
        console.log "Connection received"
        @trigger('socket:connect', response['count']);
      else
        @trigger('socket:message', response['data'])

    socket.onerror = (evt) ->
      @set { connected : false }
      @trigger('socket:error')

    socket.onclose = (evt) =>
      @set { connected : false }


  disconnect: ->
    if window.socket && window.socket.readyState == 1 # Do nothing if not connected
      console.log "Disconnecting"
      window.socket.close()
}
