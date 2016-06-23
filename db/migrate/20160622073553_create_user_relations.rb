class CreateUserRelations < ActiveRecord::Migration
  def change
    create_table :user_relations do |t|
      t.integer :user_id
      t.integer :related_user_id
      t.string :relation_type

      t.timestamps null: false
    end
  end
end
