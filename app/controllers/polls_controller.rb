class PollsController < ApplicationController

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.new(params[:poll])
    @poll.comments = []

    if @poll.save
      cookies[:"authenticated_#{@poll.pin}"] = true
      return redirect_to @poll
    else
      return render :new
    end
  end

  def show
    @poll = Poll.find(params[:id])
    return redirect_to root_url unless cookies[:"authenticated_#{@poll.pin}"]
  end

  def join
    if @poll = Poll.find_by_pin(params[:pin])
      cookies[:"authenticated_#{@poll.pin}"] = true
      redirect_to show_poll_path(@poll)
    else
      redirect_to root_path
      flash[:error] = "Ooops, that PIN didn't work. Try again?"
    end
  end

  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy!
  end
end
