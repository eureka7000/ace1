class AddWidthToConceptExercises < ActiveRecord::Migration
  def change
      add_column :concept_exercises, :width, :string
      add_column :concept_exercises, :height, :string
  end
end
