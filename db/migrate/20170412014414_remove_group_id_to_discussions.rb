class RemoveGroupIdToDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :group_id, :integer
  end
end
