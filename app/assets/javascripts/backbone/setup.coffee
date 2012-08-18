sendIfEnter = (textarea, evt) ->
  if window.socket && evt.keyCode == 13
    window.socket.send $(textarea).val()
    $(textarea).val('')

setup = ->
  if WebSocket
    $('.if-web-sockets').show()
  else
    $('.no-web-sockets').show()

  socket_wrapper = new SocketWrapper({ host : 'localhost', port : 8080 })

  connection_view = new ConnectionView { model: socket_wrapper }
  $('#connect').append connection_view.$el

  socket_messages_list_view = new MessageListView { model: socket_wrapper }
  $('#messages').append socket_messages_list_view.$el

$ ->
  setup()
  $("#message-input").keyup (event) ->
    sendIfEnter(@, event)

$(window).unload -> window.socket.close()
