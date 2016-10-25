class AddWidthToUnitConceptExerciseSolutions < ActiveRecord::Migration
  def change
      add_column :unit_concept_exercise_solutions, :width, :string
      add_column :unit_concept_exercise_solutions, :height, :string
  end
end
