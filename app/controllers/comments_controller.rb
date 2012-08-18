class CommentsController < ApplicationController
  def new

  end

  def index
    #@poll = Poll.find(params[:poll_id])
    #return @poll.comments.to_json # TODO

    respond_to do |format|
      format.json do

        return render json: [
          { text: "Hello from json!" },
          { text: "I LIKE SHOUTING ON THE INTERNET" }
        ]
      end
    end
  end
end
