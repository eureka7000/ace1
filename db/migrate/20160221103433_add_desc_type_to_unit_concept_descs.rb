class AddDescTypeToUnitConceptDescs < ActiveRecord::Migration
  def change
      add_column :unit_concept_descs, :desc_type, :string      
  end
end
