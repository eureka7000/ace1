class AddCouponIdToUsers < ActiveRecord::Migration
  def change
      add_column :users, :coupon_id, :integer
      add_column :users, :coupon_code, :string
  end
end
