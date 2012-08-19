window.CommentView = Backbone.View.extend {
  template: _.template $('#template-comment').html()

  render: ->
    $(@el).html @template(@model)
    return @
}


window.CommentListView = Backbone.View.extend {
  template: _.template $('#template-comment-list').html()

  initialize: ->
    @poll_id  = Ideaspot.get_poll_id()
    @model.on('socket:message', @onMessage, @)
    @loadComments()

  loadComments: () ->
    $('.sidebar .comments').empty()

    # TODO: Make this more Backbone-y
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

  onMessage: (msg) ->
    @render()

  render: ->
    @loadComments()
    return @
}
