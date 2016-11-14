class AddWidthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :width, :integer
  end
end
