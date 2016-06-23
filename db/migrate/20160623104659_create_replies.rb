class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
        t.integer :question_id
        t.integer :user_id
        t.text :comment
        t.integer :group_id
        t.integer :parent_reply_id
        t.integer :depth
        t.integer :order_no

        t.timestamps null: false   
    end
  end
end
