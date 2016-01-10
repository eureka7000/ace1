class CreateConcepts < ActiveRecord::Migration
  def change
    create_table :concepts do |t|
      t.string :category
      t.string :sub_category
      t.string :concept_code
      t.string :concept_name

      t.timestamps null: false
    end
  end
end
