class RemoveDiscussionIdToDiscussionTitleExplanations < ActiveRecord::Migration
  def change
    remove_column :discussion_title_explanations, :discussion_id, :integer
  end
end
