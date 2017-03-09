class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.integer :organizer
      t.integer :leader
      t.string :manage_type
      t.integer :participant_id
      t.string :observer_yn
      t.text :title
      t.string :content
      t.integer :core_unit_concept
      t.integer :related_unit_concept
      t.text :title_explanation
      t.text :answer
      t.string :grade
      t.date :expiration_date
      t.text :interim_report
      t.text :final_report

      t.timestamps null: false
    end
  end
end
