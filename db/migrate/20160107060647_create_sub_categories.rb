class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :name
      t.string :code
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
