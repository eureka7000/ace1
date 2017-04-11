class AddDepthToDiscussionReplies < ActiveRecord::Migration
  def change
    add_column :discussion_replies, :depth, :integer
  end
end
