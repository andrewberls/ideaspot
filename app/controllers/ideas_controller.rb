class IdeasController < ApplicationController
  def create

    poll = Poll.find(params[:poll_id])
    idea = poll.ideas.build(title: params[:idea][:title], votes: params[:idea][:votes])
    idea.save
    render :json => idea
  end

  def index
    @poll = Poll.find(params[:poll_id])

    respond_to do |format|
      format.json do
        return render json: @poll.ideas
      end
    end
  end


  def show
    @idea = Idea.find(params[:id])
    respond_to do |format|
      format.json do
        return render json: @idea
      end
    end
  end

end
