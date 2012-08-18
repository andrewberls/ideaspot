window.MessageView = Backbone.View.extend {
  template: _.template $('#template-socket-message').html()

  render: ->
    $(@el).html @template(@model)
    return @
}

window.MessageListView = Backbone.View.extend {
  template: _.template $('#template-socket-message-list').html()

  initialize: ->
    @model.on('socket:message', @onMessage, @)
    @data = []
    @loadMessages()

  loadMessages: () ->
    # TODO: smarter loading to prevent flicker

    $(@el).html('')

    $.ajax {
      url: "/messages.json",
      success: (json) =>
        for msg in JSON.parse(json)
          for own id, text of msg
            $(@el).append "
              <div class='message'>
                <p>#{text}</p>
              </div>
            "
    }

    #$messages = $("#messages")
    #$messages.animate { scrollTop: $messages.prop("scrollHeight") }, 1


  onMessage: (msg) ->
    @data.push { message: msg }
    @render()

  render: ->
    @loadMessages()
    return @
}
