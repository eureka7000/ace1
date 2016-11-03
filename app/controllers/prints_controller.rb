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
                "select * from (
                    select '#{Concept::SUB_CATEGORIES[params[:sub_category]]}' as sub_category_name, a.id as concept_id, a.concept_name, a.concept_code, b.id as unit_concept_id, b.name as unit_concept_name,
                            b.code, b.level, c.file_name, c.id, c.memo, 1 as question_type
                    from concepts a, unit_concepts b, unit_concept_descs c
                    where a.sub_category = '#{sub_category}'
                    and a.exercise_yn = 'concept'
                    and b.exercise_yn = 'exercise'
                    and c.desc_type = '1'
                    and a.id = b.concept_id
                    and b.id = c.unit_concept_id
                    
                    union all

                    select '#{Concept::SUB_CATEGORIES[params[:sub_category]]}' as sub_category_name, a.id as concept_id, '종합문제' as concept_name, a.concept_code, '' as unit_concept_id, '' as unit_concept_name, 
                            '' as code, '' as level, c.file_name, c.id, c.memo, 2 as question_type
                    from concepts a, concept_exercises c
                    where a.sub_category = '#{sub_category}'
                    and a.exercise_yn = 'exercise'
                    and a.id = c.concept_id
                    and c.desc_type = '1'
                ) tot
                order by question_type, tot.concept_code, tot.code, tot.memo "
            )
                             
        end
        
        render :json => @questions
        
    end      
    
end