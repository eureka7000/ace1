class AddPaypalTokenToPayments < ActiveRecord::Migration
  def change
      add_column :payments, :paypal_token, :string
      add_column :payments, :paypal_payer_id, :string
      add_column :payments, :pay_gateway, :string
  end
end
