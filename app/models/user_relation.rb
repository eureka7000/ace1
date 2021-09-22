class UserRelation < ActiveRecord::Base
    
    belongs_to :user, :foreign_key => 'user_id'
    # belongs_to :user, :foreign_key => 'related_user_id'
    
    validates_presence_of :user_id, :related_user_id, :relation_type, :confirm_status
    
    after_destroy :remove_reverse_relation
    
    CONFIRM_STATUS = {
        :requested => "요청",
        :confirmed => "승인",
        :rejected  => "거절"
    }
    
    def get_related_user_name
        User.find(self.related_user_id).user_name
    end

    def get_related_group_name
        @group_user = GroupsUser.where('user_id = ?', self.related_user_id)
        @group_id = @group_user[0].group_id
        @group = Group.where('id = ?', @group_id)
        @group[0].name
    end
    
    def self.create_relation(from, target, type)
        
        ActiveRecord::Base.transaction do 
        
            user_relation = UserRelation.new
            user_relation.user_id = from
            user_relation.related_user_id = target
            user_relation.relation_type = type
            user_relation.confirm_status = 'confirmed'
            user_relation.request_date = Time.new
            user_relation.confirmed_at = Time.new
            user_relation.save
        
            # Reverse
            reverse_relation = UserRelation.new
            reverse_relation.user_id = target
            reverse_relation.related_user_id = from
            reverse_relation.relation_type = get_reverse_type(type)
            reverse_relation.confirm_status = 'confirmed'
            reverse_relation.request_date = Time.new
            reverse_relation.confirmed_at = Time.new
            reverse_relation.save
        
            user_relation
            
        end    
        
    end 
    
    def remove_reverse_relation
        related_id = self.related_user_id
        user_relation = UserRelation.where('related_user_id = ? and user_id = ?', self.user_id, self.related_user_id)
        user_relation.destroy_all
    end

    private
    
    def self.get_reverse_type(type)
        
        if type == 'mento'
            'student'
        end    
        
    end
    
end
