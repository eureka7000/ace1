class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
        t.integer :unit_concept_id
        t.integer :to_user_id
        t.integer :user_id
        t.string :title
        t.text :content
        t.string :file_name

        t.timestamps null: false        
    end
  end
end