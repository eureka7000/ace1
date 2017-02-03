class HomesController < ApplicationController

    # before_filter :authenticate_user!

    def index

        unless current_user.nil?
            # if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
            #     @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count
            #     @session_yn = 'Y'
            # end
            @questions_number = Question.get_question_number(current_user.id)
            @session_yn = 'Y'
        end
        
        @unit_concept_count = UnitConcept.where('exercise_yn = ?','concept').count
        @question_count = UnitConcept.where('exercise_yn <> ?','concept').count
        @summary_question_count = Concept.where('exercise_yn = ?','exercise').count
        @video_count = UnitConceptDesc.where('desc_type = 4').count + ConceptExercise.where('desc_type = 4').count

        respond_to do |format|
            format.html
        end

    end

    def do_study
        @unit_concept_count = UnitConcept.where('exercise_yn = ?','concept').count
        @question_count = UnitConcept.where('exercise_yn <> ?','concept').count
        @summary_question_count = Concept.where('exercise_yn = ?','exercise').count
        @video_count = UnitConceptDesc.where('desc_type = 4').count + ConceptExercise.where('desc_type = 4').count
    end

    def contents_list
        chapter_query = "select b.category, b.sub_category, a.concept_id, b.concept_code, b.concept_name, a.id, a.code, a.name, a.level, a.grade " +
                "from unit_concepts a, concepts b " +
                "where a.concept_id = b.id " +
                "and a.exercise_yn = 'concept' " +
                "order by b.category, b.sub_category, b.concept_code, a.code"

        @chapters = UnitConcept.find_by_sql(chapter_query)

        grade_query ="select a.grade, a.chapter, a.category, a.sub_category, a.concept_id, b.concept_name, c.id as unit_concept_id, c.name as unit_concept_name, c.level as unit_concept_level "+
                "from grade_unit_concepts a, concepts b, unit_concepts c "+
                "where a.concept_id = b.id "+
                "and b.id = c.concept_id "+
                "and c.exercise_yn = 'concept' "+
                "order by a.grade, a.chapter, a.category, a.sub_category"

        @grades = GradeUnitConcept.find_by_sql(grade_query)
    end
end
