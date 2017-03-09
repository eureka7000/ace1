class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.integer :user_id
      t.integer :user_type_id

      t.timestamps null: false
    end
  end
end
