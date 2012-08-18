class Idea < ActiveRecord::Base
  attr_accessible :title, :votes

  belongs_to :poll
end
