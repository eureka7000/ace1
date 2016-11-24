class AddPostcodeToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :postcode, :string
  end
end
