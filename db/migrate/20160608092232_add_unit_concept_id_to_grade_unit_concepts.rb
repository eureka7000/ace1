class AddUnitConceptIdToGradeUnitConcepts < ActiveRecord::Migration
  def change
      remove_column :grade_unit_concepts, :unit_concept
      add_column :grade_unit_concepts, :name, :string
      add_column :grade_unit_concepts, :unit_concept_id, :integer  
  end
end
