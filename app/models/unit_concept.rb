class UnitConcept < ActiveRecord::Base
    
    belongs_to :concept
    
    has_many :unit_concept_descs
    has_many :explanations
    
    DESC_TYPES = {
        :unit_concept => "Unit Concept",
        :explanation => "Explanation",
        :exercise => "Exercise",
        :solution => "Solution",
        :video => "Video",
        :link => "link"
    }
    
end
