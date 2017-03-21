class AddDiscussionTitleExplanationIdToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :discussion_title_explanation_id, :integer
  end
end
