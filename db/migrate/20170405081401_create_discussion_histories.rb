class CreateDiscussionHistories < ActiveRecord::Migration
  def change
    create_table :discussion_histories do |t|
      t.integer :discussion_id
      t.integer :user_id
      t.integer :discussion_count

      t.timestamps null: false
    end
  end
end
