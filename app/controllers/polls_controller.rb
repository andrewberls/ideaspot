class PollsController < ApplicationController
  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.new(params[:poll])
    @poll.comments = []

    if @poll.save
      return redirect_to @poll
    else
      # Error occured - TODO: validate client side
      return render :new
    end
  end

  def show
    @poll = Poll.find(params[:id])
  end

  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy!
  end

end
