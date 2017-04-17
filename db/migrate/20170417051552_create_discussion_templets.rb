class CreateDiscussionTemplets < ActiveRecord::Migration
  def change
    create_table :discussion_templets do |t|
      t.string :code
      t.text :title
      t.text :content
      t.text :concept_explanation
      t.integer :unit_concept_id
      t.text :answer
      t.integer :level
      t.string :grade
      t.integer :user_id
      t.string :creator_type

      t.timestamps null: false
    end
  end
end
