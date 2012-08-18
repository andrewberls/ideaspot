class Comment < ActiveRecord::Base
  attr_accessible :name, :text

  belongs_to :poll
end
