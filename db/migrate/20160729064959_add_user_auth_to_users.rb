class AddUserAuthToUsers < ActiveRecord::Migration
  def change
      add_column :users, :user_auth, :string
      add_column :users, :expire_date, :datetime
  end
end
