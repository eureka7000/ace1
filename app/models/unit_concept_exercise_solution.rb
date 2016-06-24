class UnitConceptExerciseSolution < ActiveRecord::Base
    
    belongs_to :unit_concept_desc
    belongs_to :unit_concept, :foreign_key => "link"
    
    mount_uploader :file_name, ImageUploader
    
    validates_presence_of :code, :unit_concept_desc_id
    
end
