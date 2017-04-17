class RemoveDiscussionIdToDiscussionSolutions < ActiveRecord::Migration
  def change
    remove_column :discussion_solutions, :discussion_id, :integer
  end
end
