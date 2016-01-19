class AddConceptIdToUnitConcepts < ActiveRecord::Migration
  def change
      add_column :unit_concepts, :concept_id, :integer
  end
end
