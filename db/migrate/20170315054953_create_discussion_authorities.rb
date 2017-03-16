class CreateDiscussionAuthorities < ActiveRecord::Migration
  def change
    create_table :discussion_authorities do |t|
      t.integer :admin_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
