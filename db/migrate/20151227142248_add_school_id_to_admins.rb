class AddSchoolIdToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :school_id, :integer
  end
end
