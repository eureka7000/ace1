class RemoveLeaderToDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :leader, :integer
  end
end
