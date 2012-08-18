sendIfEnter = (textarea, evt) ->
  if window.socket && evt.keyCode == 13
    poll_id  = location.pathname.replace(/polls\//, '').slice(1)
    msg = $(textarea).val()

    console.log "sendIfEnter id: #{poll_id}"
    console.log "sendIfEnter msg: #{msg}"

    window.socket.send poll_id + msg
    $(textarea).val('')

setup = ->
  socket_wrapper = new SocketWrapper({ host : 'localhost', port : 8080 })

  connection_view = new ConnectionView { model: socket_wrapper }
  #$('#connect').append connection_view.$el

  comment_list_view = new CommentListView { model: socket_wrapper }
  $('.sidebar .comments').append comment_list_view.$el

$ ->
  setup()
  $("#comment-input").keyup (event) ->
    sendIfEnter(@, event)

$(window).unload -> window.socket.close()
