class CreateConceptExerciseSolutionLinks < ActiveRecord::Migration
  def change
    create_table :concept_exercise_solution_links do |t|
      t.integer :concept_exercise_id
      t.string :unit_concept_linked_id

      t.timestamps null: false
    end
  end
end
