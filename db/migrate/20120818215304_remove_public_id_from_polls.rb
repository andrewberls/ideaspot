class RemovePublicIdFromPolls < ActiveRecord::Migration
  def up
    remove_column :polls, :public_id
  end

  def down
    add_column :polls, :public_id, :string
  end
end
