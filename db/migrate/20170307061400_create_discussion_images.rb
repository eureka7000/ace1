class CreateDiscussionImages < ActiveRecord::Migration
  def change
    create_table :discussion_images do |t|
      t.integer :discussion_id
      t.string :filename
      t.integer :width
      t.integer :height

      t.timestamps null: false
    end
  end
end
