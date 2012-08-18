class PollsController < ApplicationController

  # before :check_authentication

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

  def show
    @poll = Poll.find(params[:id])
  end

  def join
    if @poll = Poll.find_by_pin(params[:pin])
      redirect_to show_poll_path(@poll)
    else
      redirect_to root_path
      flash[:error] = "woah there cowboy"
    end
  end


  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy!
  end


  # private

  # def check_authentication
  #   return redirect_to root_url unless cookies[:authenticated]
  # end
end
