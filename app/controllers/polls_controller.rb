class PollsController < ApplicationController

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.new(params[:poll])

    if @poll.save
      cookies[:"authenticated_#{@poll.pin}"] = true
      return redirect_to @poll
    else
      return render :new
    end
  end

  def show
    @poll = Poll.find(params[:id])

    unless cookies[:"authenticated_#{@poll.pin}"]
      flash[:error] = "You need a PIN to view that poll!"
      return redirect_to root_url
    end
  end

  def join
    @poll = Poll.find_by_pin(params[:pin])

    if @poll.present?
      cookies[:"authenticated_#{@poll.pin}"] = true
      redirect_to show_poll_path(@poll)
    else
      redirect_to root_url
      flash[:error] = "Oops, that PIN didn't work. Try again?"
    end
  end

  def destroy
    Poll.find(params[:id]).destroy!
  end
end
