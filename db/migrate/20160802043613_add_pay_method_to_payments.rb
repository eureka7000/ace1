class AddPayMethodToPayments < ActiveRecord::Migration
  def change
      add_column :payments, :pay_method, :string
  end
end
