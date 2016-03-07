class AddVideoToUnitConceptDescs < ActiveRecord::Migration
  def change
      add_column :unit_concept_descs, :video, :string 
  end
end
