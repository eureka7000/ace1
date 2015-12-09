class AddUserNameToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name
    add_column :users, :user_name, :string
  end
end
