class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :coupon_code
      t.integer :effective_period
      t.string :effective_period_type
      t.integer :user_id
      t.datetime :expire_from
      t.datetime :expire_to
      t.text :issued_reason

      t.timestamps null: false
    end
  end
end
