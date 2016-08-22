class UnitConcept < ActiveRecord::Base
    
    belongs_to :concept
    
    has_many :unit_concept_descs
    has_many :explanations
    has_many :unit_concept_self_evaluations
    # has_one  :grade_unit_concept
    has_many :questions
    has_many :unit_concept_exercise_solutions
    has_many :study_histories
    
    DESC_TYPES = {
        1 => "Unit Concept",
        2 => "Explanation",
        3 => "Exercise",
        4 => "Video",
        5 => "link",
        # 6 => "Solution"
        7 => "Answer"
    }
    
    GRADES = {
        1 => '중1',
        2 => '중2',
        3 => '중3',
        4 => '고1',
        5 => '고2',
        6 => '고3'
    }
    
    def self.get_level_count(concept_id)
        str = "select exercise_yn, level, count(id) as count from unit_concepts where concept_id = #{concept_id} group by exercise_yn, level order by exercise_yn, level"
        UnitConcept.find_by_sql(str)
    end
    
    def get_video_count
        self.unit_concept_descs.where('desc_type = ?', 4).count()         
    end    
    
    def get_level_star
        
        ret = ""
       
        unless self.level.nil?
            
            ret += "<span class='item-box'><span class='item'>"
            
            rst = 5 - self.level
            
            (1..self.level).each do |idx| 
                ret += " <i class='fa fa-star'></i> "
            end
            
            (1..rst).each do |idx|
                ret += " <i class='fa fa-star-o'></i> "
            end
            
            ret += "</span></span>"
        end
        
        ret
        
    end   
    
    def self.get_level_star_empty
        ret = "<span class='item-box'><span class='item'>"
        (1..5).each do |idx|
            ret += " <i class='fa fa-star-o'></i> "
        end
        ret += "</span></span>"
        ret        
    end     
    
end
