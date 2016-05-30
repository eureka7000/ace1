class CreateGradeUnitConcepts < ActiveRecord::Migration
  def change
    create_table :grade_unit_concepts do |t|
      t.string :grade
      t.string :chapter
      t.string :category
      t.string :sub_category
      t.string :code
      t.string :unit_concept

      t.timestamps null: false
    end
  end
end
