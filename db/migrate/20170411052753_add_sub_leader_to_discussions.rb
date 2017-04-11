class AddSubLeaderToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :sub_leader, :integer
  end
end
