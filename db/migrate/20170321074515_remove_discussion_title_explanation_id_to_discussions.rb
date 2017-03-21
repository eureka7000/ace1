class RemoveDiscussionTitleExplanationIdToDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :discussion_title_explanation_id, :integer
  end
end
