class AddGroupIdToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :group_id, :integer
  end
end
