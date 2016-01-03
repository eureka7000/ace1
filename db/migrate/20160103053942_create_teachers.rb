class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.integer :user_id
      t.integer :school_id
      t.string :confirm_yn
      t.datetime :confirmed_at
      t.integer :comfirmed_id

      t.timestamps null: false
    end
  end
end
