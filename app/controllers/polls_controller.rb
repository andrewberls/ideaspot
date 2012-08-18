class PollsController < ApplicationController
  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.new(params[:poll])

    if @poll.save
      return redirect_to @poll
    else
      # Error occured - TODO: validate client side
      return render :new
    end
  end
end
