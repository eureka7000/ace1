class AddDiscussionTempletIdToDiscussionProblemConditions < ActiveRecord::Migration
  def change
    add_column :discussion_problem_conditions, :discussion_templet_id, :integer
  end
end
