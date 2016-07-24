class ContentsController < ApplicationController

    before_action :authenticate_user!
    
    def exercise

        if params[:exercise_type] == "concept_exercise"
            @unit_concept = Concept.find(params[:unit_concept_id])
            @unit_concept_descs = @unit_concept.concept_exercises
            @unit_concept_name = @unit_concept.concept_name
        else
            @unit_concept = UnitConcept.find(params[:unit_concept_id])
            @unit_concept_descs = @unit_concept.unit_concept_descs
            @unit_concept_name = @unit_concept.name
        end        

        if @unit_concept.exercise_yn == 'exercise'
            
            @exercise = @unit_concept
            
            # 유형문제일 경우에만 유사문제 조회, 종합문제는 유사문제가 없음.
            unless params[:exercise_type] == "concept_exercise"
                @similar_exercises = UnitConcept.where('related_unit_concept_id = ?', @unit_concept.id )
            end 
                
            @is_exercise = 1
            
        elsif @unit_concept.exercise_yn == 'similar exercise'
            @is_exercise = 0
            @exercise = UnitConcept.find(@unit_concept.related_unit_concept_id)
            @similar_exercises = UnitConcept.where('related_unit_concept_id = ?', @unit_concept.related_unit_concept_id )
        end
        
        link_query = "select a.name, a.id, a.code from unit_concepts a, unit_concept_descs b " +
                     "where b.unit_concept_id = #{params[:unit_concept_id]} " +
                     "and b.desc_type = 5 and b.link = a.id "
        @links = UnitConceptDesc.find_by_sql(link_query)
        @self_evaluations = UnitConceptSelfEvaluation.where('user_id = ? and unit_concept_id = ?', current_user.id, params[:unit_concept_id]).order('created_at desc limit 3')
        @mento = nil
        
        unless current_user.user_relations.empty?
            @mento = User.find(current_user.user_relations[0].related_user_id)
        end    
        
    end    

    def index
        
        @view_type = params[:view_type].blank? ? '1' : params[:view_type]
        @step = params[:step].blank? ? '1' : params[:step]
        @category = params[:category]
        @sub_category = params[:sub_category]
        @concept_id = params[:concept_id]

        @grade = params[:grade]
        @chapter = params[:chapter]
        
        unless @concept_id.nil?
            @concept = Concept.find(@concept_id)
            @unit_concept_exercises = UnitConcept.where('concept_id = ? and exercise_yn = ?', @concept_id, "exercise")

            # 임시 코드 - 유형문제 파일이 올려져 있지 않으면 보여지지 않는다
            @check = 1
            @unit_concept_exercises.each do |exec|
                unless exec.unit_concept_descs.blank?
                    @check = 0
                    break
                end
            end
        end

        if @view_type == '1'
          
            if @step == '3'
              
                @concepts = Concept.where('category = ? and sub_category = ? and exercise_yn = ?', @category, @sub_category, "concept")
                @concept_exercises = Concept.where('category = ? and sub_category = ? and exercise_yn = ?', @category, @sub_category, "exercise")

                if current_user.grade.to_i > 0 && current_user.grade.to_i < 4
                    @student = 'middle'
                elsif current_user.grade.to_i > 4 && current_user.grade.to_i < 7
                    @student = 'high'
                end

                @study_level = current_user.study_level

            elsif @step == '4'

                @unit_concepts = UnitConcept.where('concept_id = ? and exercise_yn = ?', @concept_id, "concept")

                @student = params[:student]
                @level = params[:level]

                @user = User.find(current_user.id)
                @study_level = @level
                @user.study_level = @study_level
                
                @user.save
                
            elsif @step == '5'

                if params[:exercise_type] == 'concept_exercise'
                    @unit_concept_exercises = Concept.where('category = ? and sub_category = ? and exercise_yn = ?', @category, @sub_category, "exercise")
                end    
                
            end
            
        else
            if @step == '4'
                if current_user.grade.to_i > 0 && current_user.grade.to_i < 4
                    @student = 'middle'
                elsif current_user.grade.to_i > 4 && current_user.grade.to_i < 7
                    @student = 'high'
                end

                @study_level = current_user.study_level

            elsif @step == '5'
                @grade_unit_concepts = GradeUnitConcept.where('sub_category = ?', @sub_category)

                @level = params[:level]

                @user = User.find(current_user.id)
                @study_level = @level
                @user.study_level = @study_level

                @user.save
            end
        end
    end
    
    def show
        
        @unit_concept = UnitConcept.find(params[:id])
        @unit_concept_descs = @unit_concept.unit_concept_descs.order(:id).reorder(:file_name)

        link_query = "select a.name, a.id, a.code from unit_concepts a, unit_concept_descs b " +
                     "where b.unit_concept_id = #{@unit_concept.id} " +
                     "and b.desc_type = 5 and b.link = a.id " 
        
        # @links = ActiveRecord::Base.connection.execute(link_query)
        @links = UnitConceptDesc.find_by_sql(link_query)
        @videos = @unit_concept.unit_concept_descs.where('desc_type=4').order(:memo)
        @self_evaluations = UnitConceptSelfEvaluation.where('user_id = ? and unit_concept_id = ?', current_user.id, params[:id]).order('created_at desc limit 3')

        @mento = nil
        unless current_user.user_relations.empty?
            @mento = User.find(current_user.user_relations[0].related_user_id)
        end
        @unit_concepts_exercise_histories = UnitConceptExerciseHistory.where(user_id: current_user.id)



        query = "select row_number from (
select id, @curRow := @curRow + 1 AS row_number
from unit_concepts uc join (select @curRow := 0) r
where exercise_yn = 'concept' order by code
) k
where id = #{params[:id]}"
        @row_number = UnitConcept.find_by_sql(query).first
        @row_number.row_number.to_i



        @unit_concept_related = UnitConcept.find_by_sql("select * from (

select id, code, name, level, created_at, updated_at, concept_id, grade, exercise_yn, related_unit_concept_id, @curRow := @curRow + 1 AS row_number
from unit_concepts uc join (select @curRow := 0) r
where exercise_yn = 'concept' order by code
) uc limit 3 offset #{ (@row_number.row_number.to_i)-2 } ")

        logger.debug "notice" + @unit_concept_related.inspect

    end
end

