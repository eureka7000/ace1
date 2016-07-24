class UserRelation < ActiveRecord::Base
    
    belongs_to :user
    belongs_to :user, :foreign_key => "related_user_id"
    
    validates_presence_of :user_id, :related_user_id, :relation_type, :confirm_status
    
    CONFIRM_STATUS = {
        :requested => "요청",
        :confirmed => "승인",
        :rejected  => "거절"
    }
    
    def get_related_user_name
        User.find(self.related_user_id).user_name
    end    
    
end
