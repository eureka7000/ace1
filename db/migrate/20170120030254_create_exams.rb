class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :year
      t.integer :month
      t.string :exam_type
      t.integer :number
      t.integer :score
      t.text :contents

      t.timestamps null: false
    end
  end
end
