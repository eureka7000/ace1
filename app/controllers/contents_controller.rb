class ContentsController < ApplicationController

    before_action :authenticate_user!

    def index
        
        @view_type = params[:view_type].blank? ? '1' : params[:view_type]
        @step = params[:step].blank? ? '1' : params[:step]
        @category = params[:category]
        @sub_category = params[:sub_category]
        @concept_id = params[:concept_id]

        @grade = params[:grade]
        @chapter = params[:chapter]

        if @view_type == '1'
            if @step == '3'
                @concepts = Concept.where('category = ? and sub_category = ?', @category, @sub_category)

                if current_user.grade.to_i > 0 && current_user.grade.to_i < 4
                    @student = 'middle'
                elsif current_user.grade.to_i > 4 && current_user.grade.to_i < 7
                    @student = 'high'
                end

                @unit_concepts = UnitConcept.all
                @study_level = current_user.study_level

            elsif @step == '4'
                @concept = Concept.find(@concept_id)
                @unit_concepts = UnitConcept.where('concept_id = ?', @concept_id)

                @student = params[:student]
                @level = params[:level]

                @user = User.find(current_user.id)
                if @student == 'high'
                    @study_level = (@level.to_i - 2).to_s
                    @user.study_level = @study_level
                else
                    @study_level = @level
                    @user.study_level = @study_level
                end
                @user.save
            end
        else
            if @step == '5'
                @grade_unit_concepts = GradeUnitConcept.where('sub_category = ?', @sub_category)
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

        @unit_concepts_exercise_histories = UnitConceptExerciseHistory.where(user_id: current_user.id)
    end
    
end
