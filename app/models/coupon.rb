class Coupon < ActiveRecord::Base
    
    belongs_to :admin, :foreign_key => "user_id"
    
    EFFECTIVE_PERIOD_TYPE = {
        'day' => '일',
        'month' => '월',
        'year' => '년',
        'forever' => '영구'
    }    
    
end
