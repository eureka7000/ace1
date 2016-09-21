class AddUserDescToUsers < ActiveRecord::Migration
  def change
      add_column :users, :user_desc, :text
  end
end
