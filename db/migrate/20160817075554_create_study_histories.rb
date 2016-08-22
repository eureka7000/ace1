class CreateStudyHistories < ActiveRecord::Migration
  def change
    create_table :study_histories do |t|
      t.integer :user_id
      t.integer :unit_concept_id
      t.string :segment
      t.string :status

      t.timestamps null: false
    end
  end
end
