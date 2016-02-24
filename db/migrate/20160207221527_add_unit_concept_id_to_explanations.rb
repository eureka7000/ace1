class AddUnitConceptIdToExplanations < ActiveRecord::Migration
  def change
      add_column :explanations, :unit_concept_id, :integer      
  end
end
