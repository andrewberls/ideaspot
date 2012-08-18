class IdeasController < ApplicationController
  def create
    puts "^&*^&*^&* Creating Idea"
    puts params
    idea = Idea.create! params[:idea]
    render :json => document
  end
end
