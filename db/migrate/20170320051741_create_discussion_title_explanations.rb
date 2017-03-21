class CreateDiscussionTitleExplanations < ActiveRecord::Migration
  def change
    create_table :discussion_title_explanations do |t|
      t.integer :discussion_id
      t.integer :unit_concept_id
      t.text :content
      t.string :know_yn

      t.timestamps null: false
    end
  end
end
