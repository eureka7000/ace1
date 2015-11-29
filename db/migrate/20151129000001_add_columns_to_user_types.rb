class AddColumnsToUserTypes < ActiveRecord::Migration
  def change
    remove_column :user_types, :use_type
    add_column :user_types, :user_type, :string
  end
end
