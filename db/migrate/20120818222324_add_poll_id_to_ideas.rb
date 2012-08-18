class AddPollIdToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :poll_id, :integer
  end
end
