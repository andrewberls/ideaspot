# TODO: Hook comments up to Backbone models and let them take care of saving.
# All we have to is pass an event type and object id up to the hub server
# We need to somehow grab the SQL id. Returned by Backbone?
# Ex:
# msg = JSON.stringify({ type: 'comment', id: <id> })
# window.socket.send( msg )

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

  # The connection view can be used to show information about the connection status.
  # For now, I'm just leaving it around because it's required for initialization
  connection_view = new ConnectionView { model: socket_wrapper }
  #$('#connect').append connection_view.$el

  comment_list_view = new CommentListView { model: socket_wrapper }
  $('.sidebar .comments').append comment_list_view.$el

$ ->
  setup()
  $("#comment-input").keyup (event) ->
    sendIfEnter(@, event)

$(window).unload -> window.socket.close()
