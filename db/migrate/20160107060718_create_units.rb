class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.string :code
      t.integer :sub_category_id

      t.timestamps null: false
    end
  end
end
