class AddTimestampsToUnitConceptExerciseHistories < ActiveRecord::Migration
  def change
      add_column(:unit_concept_exercise_histories, :created_at, :datetime)
      add_column(:unit_concept_exercise_histories, :updated_at, :datetime)
  end
end
