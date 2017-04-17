class AddDiscussionIdToDiscussionImages < ActiveRecord::Migration
  def change
    add_column :discussion_images, :discussion_id, :integer
  end
end
