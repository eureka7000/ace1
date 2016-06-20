class CreateUnitConceptSelfEvaluations < ActiveRecord::Migration
  def change
    create_table :unit_concept_self_evaluations do |t|
      t.integer :unit_concept_id
      t.string :evaluation
      t.string :comment

      t.timestamps null: false
    end
  end
end
