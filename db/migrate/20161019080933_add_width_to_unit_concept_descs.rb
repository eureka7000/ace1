class AddWidthToUnitConceptDescs < ActiveRecord::Migration
  def change
      add_column :unit_concept_descs, :width, :string
      add_column :unit_concept_descs, :height, :string
  end
end
