class AddExerciseYnToConcepts < ActiveRecord::Migration
  def change
      add_column :concepts, :exercise_yn, :string 
  end
end
