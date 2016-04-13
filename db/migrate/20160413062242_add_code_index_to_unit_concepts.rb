class AddCodeIndexToUnitConcepts < ActiveRecord::Migration
  def change
      add_index :unit_concepts, [:concept_id, :code], :unique => true
  end
end
