class PrintsController < ApplicationController

    before_action :authenticate_admin_user!
    
    layout '/layouts/admin_main'
    
    def index
    end   
    
    def get_question_list
        
        sub_category = params[:sub_category]
        @questions = nil
        
        unless sub_category.blank?
            
            @questions = UnitConceptDesc.find_by_sql(
                "select '#{Concept::SUB_CATEGORIES[params[:sub_category]]}' as sub_category_name, a.id, a.concept_name, a.concept_code, b.id, b.name, b.code, b.level, c.*
                 from concepts a, unit_concepts b, unit_concept_descs c
                 where a.sub_category = '#{sub_category}'
                 and a.exercise_yn = 'concept'
                 and b.exercise_yn = 'exercise'
                 and c.desc_type = '1'
                 and a.id = b.concept_id
                 and b.id = c.unit_concept_id
                 order by a.concept_code, b.code, c.memo")
                 
        end
        
        render :json => @questions
        
    end      
    
end