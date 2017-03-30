class CreateDiscussionReplies < ActiveRecord::Migration
  def change
    create_table :discussion_replies do |t|
      t.integer :discussion_id
      t.integer :user_id
      t.text :comment
      t.integer :group_id
      t.integer :group_no

      t.timestamps null: false
    end
  end
end
