class CreateUnitConceptExerciseHistory < ActiveRecord::Migration
  def change
    create_table :unit_concept_exercise_histories do |t|
        t.integer :user_id
        t.integer :unit_concept_desc_id
        t.string :ox
        t.timestamp 
    end
  end
end
