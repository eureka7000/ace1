class AddGradeToUnitConcepts < ActiveRecord::Migration
    
    def change
        add_column :unit_concepts, :grade, :integer 
    end
    
end
