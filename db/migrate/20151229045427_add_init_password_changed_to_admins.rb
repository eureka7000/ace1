class AddInitPasswordChangedToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :init_password_changed, :string
  end
end
