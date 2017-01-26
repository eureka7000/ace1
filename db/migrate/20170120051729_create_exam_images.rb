class CreateExamImages < ActiveRecord::Migration
  def change
    create_table :exam_images do |t|
      t.string :filename
      t.integer :width
      t.integer :height

      t.timestamps null: false
    end
  end
end
