class AddDiscussionTempletIdToDiscussionTitleExplanations < ActiveRecord::Migration
  def change
    add_column :discussion_title_explanations, :discussion_templet_id, :integer
  end
end
