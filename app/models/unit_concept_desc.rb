class UnitConceptDesc < ActiveRecord::Base
    
    belongs_to :unit_concept
    has_many :unit_concept_exercise_solutions, :dependent => :delete_all
    has_many :unit_concept_desc_solution_links, :dependent => :delete_all
    
    mount_uploader :file_name, ImageUploader
    
end
