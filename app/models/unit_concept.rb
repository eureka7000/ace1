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

    CONTENTS_GRADES = {
        1 => '중1',
        2 => '중2',
        3 => '중3',
        4 => '고1',
        5 => '고2 & 고3 문과',
        6 => '고2 & 고3 이과'
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
    
    def get_similar_exercise_list
    
        ret = []
    
        if self.exercise_yn == 'exercise'
            
            ret << self
            
            tmps = UnitConcept.where(related_unit_concept_id: self.id).order(:code)
            
            tmps.each do | tmp |
                ret << tmp
            end    
            
        elsif self.exercise_yn == 'similar exercise'
            
            unit_concept_exercise = UnitConcept.find(self.related_unit_concept_id)
            
            ret << unit_concept_exercise
            
            tmps = UnitConcept.where(related_unit_concept_id: unit_concept_exercise.id).order(:code)
            
            tmps.each do | tmp |
                ret << tmp
            end
            
        end
        
        ret
        
    end 
    
    
    def get_next_exercise
        
        if self.exercise_yn == 'exercise'
            
            exercises = UnitConcept.where(concept_id: self.concept_id, exercise_yn: 'exercise').order(:code)
            current = false
            ret = ""
            
            exercises.each_with_index do | exercise, index |
                
                if current 
                    ret = "/contents/exercise?unit_concept_id=#{exercise.id}"
                    return ret
                end    
                
                if exercise.id == self.id && index != exercises.count
                    current = true
                end
                
            end
            
            ret
            
        elsif self.exercise_yn == 'similar exercise'
            
            unit_exercise = UnitConcept.find(self.related_unit_concept_id)
            exercises = UnitConcept.where(concept_id: unit_exercise.concept_id, exercise_yn: 'exercise').order(:code)
            
            current = false
            ret = ""
            
            exercises.each_with_index do | exercise, index |
                
                if current
                    ret = "/contents/exercise?unit_concept_id=#{exercise.id}"
                    return ret
                end
                
                if exercise.id == unit_exercise.id && index != exercises.count
                    current = true
                end    
                
            end  
            
            ret             
            
        end        
        
    end  
    
    def get_next_concept
        
        concepts = Concept.where(category: self.concept.category, sub_category: self.concept.sub_category).order(:concept_code)
        current = false
        
        concepts.each_with_index do | concept, index |
            
            if current
                return concept
            end    

            if concept.id == self.concept_id && index != concepts.count
                current = true
            end    
            
        end
        
        nil
        
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
