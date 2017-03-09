class AddAdminIdToStaff < ActiveRecord::Migration
  def change
    add_column :staffs, :admin_id, :integer
  end
end
