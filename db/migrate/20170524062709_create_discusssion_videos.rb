class CreateDiscusssionVideos < ActiveRecord::Migration
  def change
    create_table :discusssion_videos do |t|
      t.integer :number
      t.integer :discussion_templet_id

      t.timestamps null: false
    end
  end
end
