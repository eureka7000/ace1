class RemoveExpireDateToPayments < ActiveRecord::Migration
  def change
      remove_column :payments, :expire_date
  end
end
