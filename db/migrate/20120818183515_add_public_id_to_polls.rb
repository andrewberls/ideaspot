class AddPublicIdToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :public_id, :string
  end
end
