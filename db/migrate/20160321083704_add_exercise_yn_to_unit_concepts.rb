class AddExerciseYnToUnitConcepts < ActiveRecord::Migration
  def change
      add_column :unit_concepts, :exercise_yn, :string 
  end
end
