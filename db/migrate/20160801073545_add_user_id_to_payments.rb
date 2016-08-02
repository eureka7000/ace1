class AddUserIdToPayments < ActiveRecord::Migration
  def change
      add_column :payments, :user_id, :integer
      add_column :payments, :expire_date, :datetime
      add_column :payments, :service_name, :string
      add_column :payments, :payment_status, :string
  end
end
