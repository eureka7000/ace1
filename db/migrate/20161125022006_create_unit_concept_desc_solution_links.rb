class CreateUnitConceptDescSolutionLinks < ActiveRecord::Migration
  def change
    create_table :unit_concept_desc_solution_links do |t|
      t.integer :unit_concept_desc_id
      t.string :unit_concept_linked_id

      t.timestamps null: false
    end
  end
end
