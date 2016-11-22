class AddItemListPayToPayments < ActiveRecord::Migration
  def change
      add_column :payments, :item_type, :string
      add_column :payments, :item_list_pay, :string
  end
end
