class CreateInicisPayments < ActiveRecord::Migration
  def change
    create_table :inicis_payments do |t|
      t.string :version
      t.string :mid
      t.string :oid
      t.string :good_name
      t.decimal :price
      t.decimal :tax
      t.decimal :tax_free
      t.string :currency
      t.string :buyer_name
      t.string :buyer_tel
      t.string :buyer_email
      t.string :parent_email
      t.float :timestamp, :limit => 30
      t.string :signature
      t.string :return_url
      t.string :m_key
      t.string :go_pay_method
      t.string :offer_period

      t.timestamps null: false
    end
  end
end
