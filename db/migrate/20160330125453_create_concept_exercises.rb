class CreateConceptExercises < ActiveRecord::Migration
  def change
    create_table :concept_exercises do |t|
        t.integer :concept_id
        t.string :file_name
        t.string :memo
        t.string :desc_type
        t.string :video
        t.string :link        
    end
  end
end
