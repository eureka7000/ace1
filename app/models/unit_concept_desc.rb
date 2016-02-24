class UnitConceptDesc < ActiveRecord::Base
    
    belongs_to :unit_concept
    
    mount_uploader :file_name, ImageUploader
    
end
