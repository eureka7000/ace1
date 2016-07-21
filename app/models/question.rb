class Question < ActiveRecord::Base

    belongs_to :user
    belongs_to :unit_concept

    has_many :replies, :dependent => :delete_all
    
    mount_uploader :file_name, ImageUploader
    
end