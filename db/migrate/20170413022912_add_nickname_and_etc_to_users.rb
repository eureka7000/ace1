class AddNicknameAndEtcToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :etc, :text
  end
end
