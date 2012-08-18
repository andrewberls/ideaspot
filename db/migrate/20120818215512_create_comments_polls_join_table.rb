class CreateCommentsPollsJoinTable < ActiveRecord::Migration
 def change
    create_table :comments_polls, :id => false do |t|
      t.integer :comment_id
      t.integer :poll_id
    end
 end
end
