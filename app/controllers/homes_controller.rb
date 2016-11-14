class HomesController < ApplicationController

    # before_filter :authenticate_user!

    def index

        unless current_user.nil?
            if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
                @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count
                @session_yn = 'Y'
            end
        end
        
        @unit_concept_count = UnitConcept.where('exercise_yn = ?','concept').count;
        @question_count = UnitConcept.where('exercise_yn <> ?','concept').count;
        @summary_question_count = Concept.where('exercise_yn = ?','exercise').count;
        @video_count = UnitConceptDesc.where('desc_type = 4').count + ConceptExercise.where('desc_type = 4').count

        respond_to do |format|
            format.html
        end

    end

    def do_study
        @unit_concept_count = UnitConcept.where('exercise_yn = ?','concept').count;
        @question_count = UnitConcept.where('exercise_yn <> ?','concept').count;
        @summary_question_count = Concept.where('exercise_yn = ?','exercise').count;
        @video_count = UnitConceptDesc.where('desc_type = 4').count + ConceptExercise.where('desc_type = 4').count
    end

end
