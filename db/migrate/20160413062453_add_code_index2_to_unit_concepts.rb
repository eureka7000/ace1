class AddCodeIndex2ToUnitConcepts < ActiveRecord::Migration
  def change
      add_index :unit_concepts, :code, :unique => true
  end
end
