class AddLinkToUnitConceptDescs < ActiveRecord::Migration
  def change
      
      add_column :unit_concept_descs, :link, :string 
      
  end
end
