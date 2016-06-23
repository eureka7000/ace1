class AddSchoolIdToUsers < ActiveRecord::Migration
  def change
      remove_column :users, :join_channel
      add_column :users, :school_id, :integer
  end
end
