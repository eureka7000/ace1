class AddThinkTimeToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :think_time, :integer
  end
end
