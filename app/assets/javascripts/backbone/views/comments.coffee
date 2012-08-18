window.CommentView = Backbone.View.extend {
  template: _.template $('#template-comment').html()

  render: ->
    $(@el).html @template(@model)
    return @
}

window.CommentListView = Backbone.View.extend {
  template: _.template $('#template-comment-list').html()

  initialize: ->
    @poll_id  = location.pathname.replace(/polls\//, '').slice(1)
    @model.on('socket:message', @onMessage, @)
    @data = []
    @loadComments()

  loadComments: () ->
    $('.sidebar .comments').html('')

    $.ajax {
      url: "/polls/#{@poll_id}/comments.json",
      success: (json) =>
        for comment in json
          $('.sidebar .comments').append """
            <div class='comment'>
              <p class='comment-text'>#{comment.text}</p>
            </div>
          """
    }

  onMessage: (poll_id, msg) ->
    console.log "onMessage: #{msg}"
    @data.push { message: msg }
    @render()

  render: ->
    @loadComments()
    return @
}


#  <p class='comment-name'>#{comment.name}</p>
