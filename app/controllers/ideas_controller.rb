class IdeasController < ApplicationController
  def create
    idea = Idea.create! params[:idea]
    render :json => idea
  end

  def index
    @poll = Poll.find(params[:poll_id])

    respond_to do |format|
      format.json do
        # @poll.ideas
        return render json: [{title: "test", votes: 2}, { title: "idea 2", votes: 18}]
      end
    end
  end

end
