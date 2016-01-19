class CreateUnitConcepts < ActiveRecord::Migration
  def change
    create_table :unit_concepts do |t|
      t.string :code
      t.string :name
      t.integer :level

      t.timestamps null: false
    end
  end
end
