class AddConceptIdToGradeUnitConcepts < ActiveRecord::Migration
  def change
      add_column :grade_unit_concepts, :concept_id, :integer
  end
end
