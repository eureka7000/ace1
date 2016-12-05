class CreateTextbooks < ActiveRecord::Migration
  def change
    create_table :textbooks do |t|
      t.string :name
      t.integer :price
      t.integer :grade
      t.string :sub_category

      t.timestamps null: false
    end
  end
end
