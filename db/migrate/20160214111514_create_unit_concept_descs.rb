class CreateUnitConceptDescs < ActiveRecord::Migration
    
    def change
    
        create_table :unit_concept_descs do |t|
            t.integer :unit_concept_id
            t.string :file_name
            t.string :memo
            t.timestamps null: false
        end
        
    end
end
