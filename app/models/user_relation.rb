class UserRelation < ActiveRecord::Base
    
    belongs_to :user
    belongs_to :user, :foreign_key => "related_user_id"
    
end
