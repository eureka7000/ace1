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

    def chapter_list

    end

    def get_chapter_list

        query = "select b.category, b.sub_category, a.concept_id, b.concept_code, b.concept_name, a.id, a.code, a.name, a.level, a.grade " +
                "from unit_concepts a, concepts b " +
                "where a.concept_id = b.id " +
                "and a.exercise_yn = 'concept' " +
                "order by b.category, b.sub_category, b.concept_code, a.code"

        @rs = UnitConcept.find_by_sql(query)

        ret = []

        @rs.each do | rs |

            tmp = {
                    category: Concept::CATEGORIES[rs.category],
                    category_code: rs.category,
                    sub_category: Concept::SUB_CATEGORIES[rs.sub_category],
                    sub_category_code: rs.sub_category,
                    concept_name: rs.concept_name,
                    concept_id: rs.concept_id,
                    unit_concept_id: rs.id,
                    unit_concept_name: rs.name,
                    unit_concept_level: rs.level,
                    unit_concept_grade: rs.grade
            }

            ret << tmp

        end

        render :json => ret

    end

    def get_grade_list

        query ="select a.grade, a.chapter, a.category, a.sub_category, a.concept_id, b.concept_name, c.id as unit_concept_id, c.name as unit_concept_name, c.level as unit_concept_level "+
                "from grade_unit_concepts a, concepts b, unit_concepts c "+
                "where a.concept_id = b.id "+
                "and b.id = c.concept_id "+
                "and c.exercise_yn = 'concept' "+
                "order by a.grade, a.chapter, a.category, a.sub_category"

        @rs = GradeUnitConcept.find_by_sql(query)

        ret = []

        @rs.each do | rs |

            tmp = {
                    grade: UnitConcept::CONTENTS_GRADES[rs.grade.to_i],
                    grade_code: rs.grade,
                    chapter: GradeUnitConcept::CHAPTERS[rs.chapter.to_i],
                    chapter_code: rs.chapter,
                    category: GradeUnitConcept::CATEGORIES[rs.category.to_i],
                    category_code: rs.category,
                    sub_category: GradeUnitConcept::SUB_CATEGORIES[rs.sub_category.to_i],
                    sub_category_code: rs.sub_category,
                    concept_id: rs.concept_id,
                    concept_name: rs.concept_name,
                    unit_concept_id: rs.unit_concept_id,
                    unit_concept_name: rs.unit_concept_name,
                    unit_concept_level: rs.unit_concept_level
            }

            ret << tmp

            # logger.info "This is result" + "| #{rs. grade}" +" | #{rs. chapter}"+ " | #{rs. category}" + " | #{rs. sub_category}"+ " | #{rs. concept_id}" + " | #{rs. concept_name}" + " | #{rs. unit_concept_id}" + " | #{rs. unit_concept_name}" + " | #{rs. unit_concept_level}"
        end

        render :json => ret

    end
end
