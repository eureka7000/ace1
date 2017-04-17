class RemoveDiscussionIdToDiscussionImages < ActiveRecord::Migration
  def change
    remove_column :discussion_images, :discussion_id, :integer
  end
end
