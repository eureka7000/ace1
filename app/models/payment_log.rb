class PaymentLog < ActiveRecord::Base
    
    belongs_to :user
    
    validates_presence_of :user_id, :pg, :result_code, :result_message, :result_detail
    
end
