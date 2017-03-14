class AddSolutionToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :solution, :text
  end
end
