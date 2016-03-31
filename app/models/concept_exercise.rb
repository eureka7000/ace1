class ConceptExercise < ActiveRecord::Base
    
    belongs_to :concept
    
    mount_uploader :file_name, ImageUploader
    
end
