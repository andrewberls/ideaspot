class IdeasController < ApplicationController
  def create
    idea = Idea.create! params[:idea]
    render :json => idea
  end
end
