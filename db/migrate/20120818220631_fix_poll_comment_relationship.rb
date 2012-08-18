class FixPollCommentRelationship < ActiveRecord::Migration
  def up
    drop_table :comments_polls
    add_column :comments, :poll_id, :integer
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
