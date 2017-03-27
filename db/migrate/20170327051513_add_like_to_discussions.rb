class AddLikeToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :like, :integer
  end
end
