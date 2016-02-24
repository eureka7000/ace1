class UnitConcept < ActiveRecord::Base
    
    belongs_to :concept
    
    has_many :unit_concept_descs
    has_many :explanations
    
    DESC_TYPES = {
        :unit_concept_desc => "Unit Concept Desc",
        :explanation => "Explanation"
    }    
    
end
