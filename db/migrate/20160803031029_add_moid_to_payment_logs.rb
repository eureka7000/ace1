class AddMoidToPaymentLogs < ActiveRecord::Migration
  def change
      add_column :payment_logs, :moid, :string
  end
end
