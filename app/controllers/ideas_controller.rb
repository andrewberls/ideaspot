class IdeasController < ApplicationController
  def create
    idea = Idea.create! params[:idea]
  end
end
