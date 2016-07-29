class CreatePaymentLogs < ActiveRecord::Migration
  def change
    create_table :payment_logs do |t|
        
        t.integer :user_id   
        t.string :pg         
        t.string :result_code
        t.string :result_message
        t.text   :result_detail

        t.timestamps null: false           
    end
  end
end
