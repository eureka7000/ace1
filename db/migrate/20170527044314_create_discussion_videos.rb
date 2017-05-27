class CreateDiscussionVideos < ActiveRecord::Migration
  def change
    create_table :discussion_videos do |t|
      t.string :content
      t.integer :discussion_templet_id

      t.timestamps null: false
    end
  end
end
