class AddRelatedUnitConceptIdToUnitConcepts < ActiveRecord::Migration
  def change
    add_column :unit_concepts, :related_unit_concept_id, :integer
  end
end
