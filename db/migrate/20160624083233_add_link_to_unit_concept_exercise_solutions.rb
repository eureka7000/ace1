class AddLinkToUnitConceptExerciseSolutions < ActiveRecord::Migration
  def change
      add_column :unit_concept_exercise_solutions, :link, :integer
  end
end
