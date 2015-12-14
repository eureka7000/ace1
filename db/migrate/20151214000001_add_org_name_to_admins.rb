class AddOrgNameToAdmins < ActiveRecord::Migration
  
    def change

        add_column :admins, :org_name, :string
        add_column :admins, :admin_type, :string

    end
    
end
