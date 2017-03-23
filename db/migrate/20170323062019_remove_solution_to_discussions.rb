class RemoveSolutionToDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :solution, :text
  end
end
