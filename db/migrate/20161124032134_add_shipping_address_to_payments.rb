class AddShippingAddressToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :shipping_address, :string
  end
end
