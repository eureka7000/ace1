class UnitConceptExerciseHistory < ActiveRecord::Base
    
    belongs_to :unit_concept_desc
    belongs_to :user
    
    validates_presence_of :user_id, :unit_concept_desc_id
    
end
