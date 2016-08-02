class AddOidToPayments < ActiveRecord::Migration
    def change
        add_column :payments, :oid, :string
        remove_column :payments, :name
    end
end
