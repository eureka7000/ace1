class AddColumnsToUsers < ActiveRecord::Migration
  def change

    add_column :users, :name, :string
    add_column :users, :location, :string
    add_column :users, :phone, :string
    
  end
end
