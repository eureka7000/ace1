class Question < ActiveRecord::Base

    belongs_to :user
    belongs_to :unit_concept
    
    mount_uploader :file_name, ImageUploader
    
end
