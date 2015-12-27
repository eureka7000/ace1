class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :grade
      t.boolean :is_school
      t.string :address
      t.string :phone

      t.timestamps null: false
    end
  end
end
