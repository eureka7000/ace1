class AddDiscussionTempletIdToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :discussion_templet_id, :integer
  end
end
