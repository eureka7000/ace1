class PrintsController < ApplicationController

    before_action :authenticate_admin_user!
    
    layout '/layouts/admin_main'
    
    def index
    end
    
    def solutions
    end
    
    def exercises
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
                            '' as code, a.level as level, c.file_name, c.id, c.memo, 2 as question_type
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
    
    def get_solution_list
        
        sub_category = params[:sub_category]
        @solutions = nil
        
        unless sub_category.blank?
       
            @solutions = UnitConceptDesc.find_by_sql(
                "select * from (
    	            select '#{Concept::SUB_CATEGORIES[params[:sub_category]]}' as sub_category_name, a.id as concept_id, a.concept_name, a.concept_code, b.id as unit_concept_id, b.name as unit_concept_name,
                           b.code, b.level, c.file_name, c.id, c.memo, 1 as question_type, c.desc_type
                    from concepts a, unit_concepts b, unit_concept_descs c
                    where a.sub_category = '#{sub_category}'
                    and a.exercise_yn = 'concept'
    	            and b.exercise_yn = 'exercise'
                    and c.desc_type in ('7','3')
                    and a.id = b.concept_id
                    and b.id = c.unit_concept_id
                    
                    union all
 
                    select '#{Concept::SUB_CATEGORIES[params[:sub_category]]}' as sub_category_name, a.id as concept_id, '종합문제' as concept_name, a.concept_code, '' as unit_concept_id, '' as unit_concept_name, 
                           '' as code, a.level as level, c.file_name, c.id, c.memo, 2 as question_type, c.desc_type
                    from concepts a, concept_exercises c
                    where a.sub_category = '#{sub_category}'
                    and a.exercise_yn = 'exercise'
                    and a.id = c.concept_id
                    and c.desc_type in ('7','3')
                ) tot
                order by question_type, tot.concept_code, tot.code, tot.memo "
            ) 
        
        end
        
        render :json => @solutions
        
    end
    
    def get_exercise_list
        
        sub_category = params[:sub_category]
        @solutions = nil
        
        unless sub_category.blank?
       
            @solutions = UnitConceptExerciseSolution.find_by_sql(
                "select '#{Concept::SUB_CATEGORIES[params[:sub_category]]}' as sub_category_name, a.id as concept_id, a.concept_name, a.concept_code, b.id as unit_concept_id, b.name as unit_concept_name,
                        b.code, b.level, c.desc_type, d.file_name, d.memo, d.id, d.ox
                 from concepts a, unit_concepts b, unit_concept_descs c, unit_concept_exercise_solutions d
                 where a.sub_category = '#{sub_category}'
                 and a.exercise_yn = 'concept'
                 and b.exercise_yn = 'concept'
                 and c.desc_type = '3'
                 and a.id = b.concept_id
                 and b.id = c.unit_concept_id
                 and c.id = d.unit_concept_desc_id
                 order by a.concept_code, b.code, d.memo"
            )
        
        end
        
        render :json => @solutions        
        
    end    
    
end