class CreateUnitConceptExerciseSolutions < ActiveRecord::Migration
  def change
    create_table :unit_concept_exercise_solutions do |t|
        t.integer :unit_concept_desc_id
        t.string :code
        t.string :file_name
        t.string :memo
        t.timestamps
    end
  end
end
