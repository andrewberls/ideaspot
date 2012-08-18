class CommentsController < ApplicationController
  def create
    @poll = Poll.find(params[:poll_id])
    @comment = @poll.comments.build(text: params[:text])
    @comment.save
  end

  def index
    @poll = Poll.find(params[:poll_id])
    #return @poll.comments.to_json # TODO

    respond_to do |format|
      format.json do
        return render json: @poll.comments
      end
    end
  end
end
