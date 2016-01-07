class CreateSubUnits < ActiveRecord::Migration
  def change
    create_table :sub_units do |t|
      t.string :name
      t.string :code
      t.integer :unit_id
      t.string :grade

      t.timestamps null: false
    end
  end
end
