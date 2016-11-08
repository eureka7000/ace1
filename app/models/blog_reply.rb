class BlogReply < ActiveRecord::Base
    belongs_to :blog
    belongs_to :user

    validates_presence_of :user_id
end
