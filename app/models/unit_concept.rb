class UnitConcept < ActiveRecord::Base
    
    belongs_to :concept
    
    has_many :unit_concept_descs
    has_many :explanations
    has_many :unit_concept_self_evaluations
    has_one  :grade_unit_concept
    has_many :questions
    
    DESC_TYPES = {
        1 => "Unit Concept",
        2 => "Explanation",
        3 => "Exercise",
        4 => "Video",
        5 => "link"
        # 6 => "Solution"
    }
    
    GRADES = {
        1 => '중1',
        2 => '중2',
        3 => '중3',
        4 => '고1',
        5 => '고2',
        6 => '고3'
    }
    
end
