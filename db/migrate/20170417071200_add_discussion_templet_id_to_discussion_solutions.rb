class AddDiscussionTempletIdToDiscussionSolutions < ActiveRecord::Migration
  def change
    add_column :discussion_solutions, :discussion_templet_id, :integer
  end
end
