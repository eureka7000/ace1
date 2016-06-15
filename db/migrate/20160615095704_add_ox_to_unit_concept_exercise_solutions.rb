class AddOxToUnitConceptExerciseSolutions < ActiveRecord::Migration
  def change
      add_column :unit_concept_exercise_solutions, :ox, :string
  end
end
