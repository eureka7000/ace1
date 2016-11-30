class ConceptExercise < ActiveRecord::Base
    
    belongs_to :concept
    has_many :concept_exercise_solution_links, :dependent => :delete_all
    
    mount_uploader :file_name, ImageUploader
    
end
