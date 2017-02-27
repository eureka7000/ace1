class AddLoginTokenToUsers < ActiveRecord::Migration

  def self.up
    change_table "users" do |t|
      t.string "login_token"
    end
  end

  def self.down
    change_table "users" do |t|
      t.remove "login_token"
    end
  end
end
