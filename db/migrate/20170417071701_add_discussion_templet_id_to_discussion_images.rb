class AddDiscussionTempletIdToDiscussionImages < ActiveRecord::Migration
  def change
    add_column :discussion_images, :discussion_templet_id, :integer
  end
end
