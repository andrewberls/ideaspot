sendIfEnter = (textarea, evt) ->
  if window.socket && evt.keyCode == 13
    poll_id  = location.pathname.replace(/polls\//, '').slice(1)
    msg = $(textarea).val()

    # 'Hack'-athon indeed. Force 6 digits so we know how to slice the poll id.
    padded_poll_id = ( poll_id + "xxxxxx" ).slice(0, 6)
    window.socket.send("#{padded_poll_id}#{msg}")
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
