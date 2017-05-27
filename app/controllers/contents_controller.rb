class ContentsController < ApplicationController

    before_action :authenticate_user!
    
    layout '/layouts/contents'

    def by_level
        
    end    


    def get_grade_list

        query ="select a.grade, a.chapter, a.category, a.sub_category, a.concept_id, b.concept_name, c.id as unit_concept_id, c.name as unit_concept_name, c.level as unit_concept_level
        from grade_unit_concepts a, concepts b, unit_concepts c
        where a.concept_id = b.id
        and b.id = c.concept_id
        and c.exercise_yn = 'concept'
        and a.grade = c.grade
        order by a.grade, a.chapter, a.category, a.sub_category"

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
                unit_concept_name: rs.name
            }
            
            ret << tmp
            
        end    
        
        render :json => ret
        
    end

    def exercise
        
        @exercise_yn = true
        @view_type = params[:view_type]
        @grade = params[:grade]
        @chapter = params[:chapter]
        @category = params[:category]
        @sub_category = params[:sub_category]
        @concept_id = params[:concept_id]
        @step = params[:step]

        if params[:exercise_type] == "concept_exercise"
            
            #종합문제일 때
            @unit_concept = Concept.find(params[:unit_concept_id])
            @unit_concept_descs = @unit_concept.concept_exercises.order(:id).reorder(:file_name)
            @unit_concept_name = @unit_concept.concept_name
            
            @concepts = []
            @concept_answers = []
            @concept_descs = []
            @solutions = []
            @videos = []
            
#            @unit_concept.concept_exercises.each do | unit_concept_desc |
            @unit_concept_descs.each do | unit_concept_desc |
            
                if unit_concept_desc.desc_type == '1'
                    @concepts << unit_concept_desc
                elsif unit_concept_desc.desc_type == '2'
                    @concept_descs << unit_concept_desc
                elsif unit_concept_desc.desc_type == '3'
                    @solutions << unit_concept_desc
                elsif unit_concept_desc.desc_type == '4'
                    @videos << unit_concept_desc
                elsif unit_concept_desc.desc_type == '7'
                    @concept_answers << unit_concept_desc    
                end        
            
            end
            
            @exercise_type = 'concept_exercise'
            
        else
            #유형문제일 때
            @unit_concept = UnitConcept.find(params[:unit_concept_id])
            @unit_concept_descs = @unit_concept.unit_concept_descs.order(:memo)
            @unit_concept_name = @unit_concept.name
            
            @concepts = []
            @concept_answers = []
            @concept_descs = []
            @solutions = []
            @videos = []

            @unit_concept_descs.each do | unit_concept_desc |
            
                if unit_concept_desc.desc_type == '1'
                    @concepts << unit_concept_desc
                elsif unit_concept_desc.desc_type == '2'
                    @concept_descs << unit_concept_desc
                elsif unit_concept_desc.desc_type == '3'
                    @solutions << unit_concept_desc
                elsif unit_concept_desc.desc_type == '4'
                    @videos << unit_concept_desc
                elsif unit_concept_desc.desc_type == '7'
                    @concept_answers << unit_concept_desc    
                end

            end
            
            # @concepts = UnitConceptDesc.where(unit_concept_id: @unit_concept, desc_type: 1)
            # @concept_answers = UnitConceptDesc.where(unit_concept_id: @unit_concept, desc_type: 7)
            # @concept_descs = UnitConceptDesc.where(unit_concept_id: @unit_concept, desc_type: 2)
            # @solutions = UnitConceptDesc.where(unit_concept_id: @unit_concept, desc_type: 3)
            # @videos = UnitConceptDesc.where(unit_concept_id: @unit_concept, desc_type: 4).order(:memo)
            
            @exercise_type = 'unit_concept_exercise'
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
        @step = params[:step].blank? ? 1 : params[:step].to_i
        @category = params[:category]
        @grade = params[:grade]
        @sub_category = params[:sub_category]
        @chapter = params[:chapter]
        @concept_id = params[:concept_id]        
        @level = params[:level]        
        
        @breadcrumbs = []
        @items = []
        
        if current_user.grade.to_i > 0 && current_user.grade.to_i < 4
            @student = 'middle'
        elsif current_user.grade.to_i > 3 && current_user.grade.to_i < 7
            @student = 'high'
        end

        @study_level = current_user.study_level
                
        
        if @view_type == '1'  # 단원별
            
            # breadcrumbs
            if @step > 0
                @current_page_name = '단원별 학습'
                @breadcrumbs << { 'step1' => '단원별 학습' }
            end
                
            if @step > 1
                @current_page_name = Concept::CATEGORIES[@category]
                @breadcrumbs << { 'step2' => @current_page_name }
            end
            
            if @step > 2
                @current_page_name = Concept::SUB_CATEGORIES[@sub_category]
                @breadcrumbs << { 'step3' => @current_page_name }
            end
            
            if @step > 3
                if params[:exercise_type].blank?
                    @concept = Concept.find(params[:concept_id])                
                    @current_page_name = @concept.concept_name
                else
                    @current_page_name = '종합문제'
                end        
                @breadcrumbs << { 'step4' => @current_page_name }                
            end
            
            if @step > 4
                @current_page_name = '유형문제'
                @breadcrumbs << { 'step5' => @current_page_name }
            end
            
            # Data
            if @step == 1
                Concept::CATEGORIES.each_pair do |key, value|
                    @items << {
                        key: key,
                        value: value
                    }
                end
            elsif @step == 2   # sub category view
                
                if @category.nil?
                    redirect_to "/contents?view_type=1&step=1"
                    return
                end    
                
                Concept::SUB_CATEGORIES.each_pair do |key, value|
                    if @category.first(2) == key.first(2)
                        @items << {
                            key: key,
                            value: value
                        }                        
                    end
                end
            elsif @step == 3   # concept view
                @concepts = Concept.where('category = ? and sub_category = ? and exercise_yn = ?', @category, @sub_category, "concept")
                @concepts.each do |concept|
                    @items << {
                        key: concept.id,
                        value: concept.concept_name,
                        load_modal: true,        # 난이도 설정 모달.
                        drop_down: true,
                        unit_concept_counts: get_unit_concept_counts(concept.id)
                    }
                end
                
                @concept_exercises = Concept.where('category = ? and sub_category = ? and exercise_yn = ?', @category, @sub_category, "exercise")
                if @concept_exercises.length > 0
                    @items << {
                        key: '',
                        value: '종합문제'
                    }
                end
                
            elsif @step == 4
                
                if params[:exercise_type] == 'concept_exercise' # 종합문제일 경우
                    @concept_exercises = Concept.where('category = ? and sub_category = ? and exercise_yn = ?', @category, @sub_category, "exercise").order(:concept_code)
                    @concept_exercises.each do |concept_exercise|
                        @items << {
                            key: concept_exercise.id,
                            value: concept_exercise.concept_name,
                            content_yn: true,
                            level: concept_exercise.level,
                            exercise_yn: true,
                            level_star_yn: true,
                            level_star: concept_exercise.get_level_star,
                            past_test: concept_exercise.past_test_org.blank? ? "" : concept_exercise.past_test_year + "년 " + concept_exercise.past_test_month + "월 " + concept_exercise.past_test_type + " " + Concept::PAST_TEST_ORGS[concept_exercise.past_test_org] 
                        }
                    end                    
                else    
                    @unit_concepts = UnitConcept.where('concept_id = ? and exercise_yn = ? and level <= ?', @concept_id, "concept", @level) 
                    @unit_concepts.each do |unit_concept|
                        @items << {
                            key: unit_concept.id,
                            value: unit_concept.name,
                            content_yn: true,
                            level: unit_concept.level,
                            level_star_yn: true,
                            level_star: unit_concept.get_level_star
                        }
                    end
                
                    @unit_concept_exercises = UnitConcept.where('concept_id = ? and exercise_yn = ?', @concept_id, "exercise")                
                    if @unit_concept_exercises.length > 0
                        @items << {
                            key: '',
                            value: '유형문제',
                            level: 0,
                            level_star_yn: true,
                            level_star: UnitConcept.get_level_star_empty
                        }                    
                    end    
                end 
                
            elsif @step == 5
                
                @concept = Concept.find(@concept_id)
                @unit_concept_exercises = UnitConcept.where('concept_id = ? and exercise_yn = ?', @concept_id, "exercise")
                @unit_concept_exercises.each do |unit_concept_exercise|
                    
                    @items << {
                        key: unit_concept_exercise.id,
                        value: unit_concept_exercise.name,
                        content_yn: true,
                        level: unit_concept_exercise.level,
                        level_star_yn: true,
                        level_star: unit_concept_exercise.get_level_star,
                        exercise_yn: true,
                        video_count: unit_concept_exercise.get_video_count
                    }
                end
                
            end    
            
        elsif @view_type == '2' # 학년별
            
            # breadcrumbs
            if @step > 0
                @current_page_name = '학년별 학습'
                @breadcrumbs << { 'step1' => '학년별 학습' }
            end
            
            if @step > 1
                @current_page_name = UnitConcept::CONTENTS_GRADES[@grade.to_i]
                @breadcrumbs << { 'step2' => @current_page_name }
            end   
            
            if @step > 2
                @current_page_name = GradeUnitConcept::CHAPTERS[@chapter.to_i]
                @breadcrumbs << { 'step3' => @current_page_name }
            end    
            
            if @step > 3
                @current_page_name = GradeUnitConcept::CATEGORIES[@category.to_i]
                @breadcrumbs << { 'step4' => @current_page_name }                
            end
            
            if @step > 4
                @current_page_name = GradeUnitConcept::SUB_CATEGORIES[params[:sub_category].to_i]
                @breadcrumbs << { 'step5' => @current_page_name }

                unless params[:exercise_type].blank?
                  @current_page_name = '종합문제'
                end
            end
            
            if @step > 5
                if params[:exercise_type].blank?
                    @current_page_name = Concept.find(@concept_id).concept_name
                else
                    @current_page_name = '종합문제'
                end
                @breadcrumbs << { 'step6' => @current_page_name }
            end
            
            if @step > 6
                @current_page_name = '유형문제'
                @breadcrumbs << { 'step7' => @current_page_name }
            end    
            
            # data
            if @step == 1
                UnitConcept::CONTENTS_GRADES.each_pair do |key, value|
                    @items << {
                        key: key,
                        value: value
                    }
                end
            elsif @step == 2    
                GradeUnitConcept::CHAPTERS.each_pair do |key, value|
                    unless @grade.to_i != key/100 
                        @items << {
                            key: key,
                            value: value
                        }
                    end    
                end
            elsif @step == 3
                GradeUnitConcept::CATEGORIES.each_pair do |key, value|
                    unless @chapter.to_i != key/100
                        @items << {
                            key: key,
                            value: value
                        }
                    end    
                end
            elsif @step == 4    
                first_key = ''
                count = 0
                GradeUnitConcept::SUB_CATEGORIES.each_pair do |key, value|
                    unless @category.to_i != key/100
                        @items << {
                            key: key,
                            value: value
                        }
                    end

                    if count == 0
                      first_key = key
                      count = count + 1
                    end
                end

            #     종합문제 표시 위치 변경
                unless GradeUnitConcept::MAPPING_EXERCISE[@category].nil?

                      @concept_exercises = Concept.where('sub_category in (?)  and exercise_yn = ? and grade = ? ', GradeUnitConcept::MAPPING_EXERCISE[@category], "exercise", @grade)

                      if @concept_exercises.count > 0

                          @items << {
                              key: first_key,
                              value: '종합문제'
                          }
                      end
                  end

            elsif @step == 5

              if params[:exercise_type] == 'concept_exercise' # 종합문제일 경우
                @concept_exercises = Concept.where('sub_category in (?) and exercise_yn = ? and grade <= ? ', GradeUnitConcept::MAPPING_EXERCISE[@category], "exercise", @grade)
                @concept_exercises.each do |concept_exercise|
                  @items << {
                      key: concept_exercise.id,
                      value: concept_exercise.concept_name,
                      content_yn: true,
                      level: concept_exercise.level,
                      exercise_yn: true,
                      level_star_yn: true,
                      level_star: concept_exercise.get_level_star,
                      past_test: concept_exercise.past_test_org.blank? ? "" : concept_exercise.past_test_year + "년 " + concept_exercise.past_test_month + "월 " + concept_exercise.past_test_type + " " + Concept::PAST_TEST_ORGS[concept_exercise.past_test_org]
                  }
                end

              else

                @grade_unit_concepts = GradeUnitConcept.where('sub_category = ?', @sub_category)
                @grade_unit_concepts.each do |grade_unit_concept|
                    @items << {
                        key: grade_unit_concept.concept.id,
                        value: grade_unit_concept.concept.concept_name,
                        load_modal: true,        # 난이도 설정 모달.
                        drop_down: true,
                        unit_concept_counts: get_unit_concept_counts(grade_unit_concept.concept_id)                        
                    }
                end
              end

                # unless GradeUnitConcept::MAPPING_EXERCISE[@category].nil?
                #
                #     @concept_exercises = Concept.where('sub_category in (?)  and exercise_yn = ? and grade = ? ', GradeUnitConcept::MAPPING_EXERCISE[@category], "exercise", @grade)
                #
                #     if @concept_exercises.count > 0
                #         @items << {
                #             key: '',
                #             value: '종합문제'
                #         }
                #     end
                # end




            elsif @step == 6
                
                if params[:exercise_type] == 'concept_exercise' # 종합문제일 경우

                    # num = @sub_category.to_s.slice(-2, 1).to_i - 1
                    # str = GradeUnitConcept::MAPPING_EXERCISE[@category]
                    # logger.info "##############    sub_category : #{@sub_category}     ##############"
                    # logger.info "##############    num : #{num}     ##############"
                    # @concept_exercises = Concept.where('sub_category in (?) and exercise_yn = ? and grade <= ? ', str[num], "exercise", @grade)

                    @concept_exercises = Concept.where('sub_category in (?) and exercise_yn = ? and grade <= ? ', GradeUnitConcept::MAPPING_EXERCISE[@category], "exercise", @grade)
                    @concept_exercises.each do |concept_exercise|
                        @items << {
                            key: concept_exercise.id,
                            value: concept_exercise.concept_name,
                            content_yn: true,
                            level: concept_exercise.level,
                            exercise_yn: true,
                            level_star_yn: true,
                            level_star: concept_exercise.get_level_star,
                            past_test: concept_exercise.past_test_org.blank? ? "" : concept_exercise.past_test_year + "년 " + concept_exercise.past_test_month + "월 " + concept_exercise.past_test_type + " " + Concept::PAST_TEST_ORGS[concept_exercise.past_test_org]
                        }
                    end

                else

                    @unit_concepts = UnitConcept.where('concept_id = ? and exercise_yn = ? and grade = ?', @concept_id, "concept", @grade)
                    @unit_concepts.each do |unit_concept|
                        @items << {
                            key: unit_concept.id,
                            value: unit_concept.name,
                            content_yn: true,
                            level: unit_concept.level,
                            level_star_yn: true,
                            level_star: unit_concept.get_level_star
                        }
                    end
            
                    @unit_concept_exercises = UnitConcept.where('concept_id = ? and exercise_yn = ?', @concept_id, "exercise")                
                    if @unit_concept_exercises.length > 0
                        @items << {
                            key: '',
                            value: '유형문제',
                            level: 0,
                            level_star_yn: true,
                            level_star: UnitConcept.get_level_star_empty
                        }                    
                    end
                    
                end
                
            elsif @step == 7

                @unit_concept_exercises = UnitConcept.where('concept_id = ? and exercise_yn = ? and grade <= ?', @concept_id, "exercise", @grade)

                @unit_concept_exercises.each do |unit_concept_exercise|
                    
                    @items << {
                        key: unit_concept_exercise.id,
                        value: unit_concept_exercise.name,
                        content_yn: true,
                        level: unit_concept_exercise.level,
                        level_star_yn: true,
                        level_star: unit_concept_exercise.get_level_star,
                        exercise_yn: true,
                        video_count: unit_concept_exercise.get_video_count
                    }
                end

            end
            
        end

    end
    
    
    def show
        
        @exercise_yn = false
        @unit_concept = UnitConcept.find(params[:id])
        @concepts = []
        @concept_descs = []
        @exercises = []
        @videos = []
        @unit_concept_descs = @unit_concept.unit_concept_descs.order(:memo)

        @unit_concept_descs.each do | unit_concept_desc |
            
            if unit_concept_desc.desc_type == '1'
                @concepts << unit_concept_desc
            elsif unit_concept_desc.desc_type == '2'
                @concept_descs << unit_concept_desc
            elsif unit_concept_desc.desc_type == '3'
                @exercises << unit_concept_desc
            elsif unit_concept_desc.desc_type == '4'
                @videos << unit_concept_desc
            end        
            
        end    
        
        # @concepts = UnitConceptDesc.where(unit_concept_id: @unit_concept, desc_type: 1)
        # @concept_descs = UnitConceptDesc.where(unit_concept_id: @unit_concept, desc_type: 2)
        # @exercises = UnitConceptDesc.where(unit_concept_id: @unit_concept, desc_type: 3)
        # @videos = UnitConceptDesc.where(unit_concept_id: @unit_concept, desc_type: 4).order(:memo)

        link_query = "select a.name, a.id, a.code from unit_concepts a, unit_concept_descs b " +
                     "where b.unit_concept_id = #{@unit_concept.id} " +
                     "and b.desc_type = 5 and b.link = a.id " 
        
        # @links = ActiveRecord::Base.connection.execute(link_query)
        @links = UnitConceptDesc.find_by_sql(link_query)
        @self_evaluations = UnitConceptSelfEvaluation.where('user_id = ? and unit_concept_id = ?', current_user.id, params[:id]).order('created_at desc limit 3')

        @mento = nil
        unless current_user.user_relations.empty?
            @mento = User.find(current_user.user_relations[0].related_user_id)
        end
        @unit_concepts_exercise_histories = UnitConceptExerciseHistory.where(user_id: current_user.id)
        @questions = Question.where('unit_concept_id = ?',params[:id]).order(created_at: :desc).limit(10)


        unless params[:id].to_i() == 1
            
            query = "select row_number from ( 
                        select id, @curRow := @curRow + 1 AS row_number
                        from unit_concepts uc join (select @curRow := 0) r
                        where exercise_yn = 'concept' order by code
                        ) k
                        where id = #{params[:id]}"
            @row_number = UnitConcept.find_by_sql(query).first
            @row_number.row_number.to_i

            # @unit_concept_related = UnitConcept.find_by_sql("select * from (
            #     select id, code, name, level, created_at, updated_at, concept_id, grade, exercise_yn, related_unit_concept_id, @curRow := @curRow + 1 AS row_number
            #     from unit_concepts uc join (select @curRow := 0) r
            #     where exercise_yn = 'concept' order by code
            #     ) uc limit 3 offset #{ (@row_number.row_number.to_i)-2 } ")

        else
            # @unit_concept_related = UnitConcept.first(2)
        end
        
        # 학습이력 저장.
        study_history = StudyHistory.where('user_id = ? and unit_concept_id = ? and segment = ?', current_user.id, @unit_concept.id, 'concept')
        
        if study_history.count > 0
            study_history[0].study_count = study_history[0].study_count + 1
            study_history[0].save
        else
            study_history = StudyHistory.new
            study_history.user_id = current_user.id
            study_history.unit_concept_id = @unit_concept.id
            study_history.segment = 'concept'
            study_history.status = 'start'
            study_history.save
        end        
        # 학습이력 저장 끝.

        # 개념화면 url
        @view_type = params[:view_type]
        @step = params[:step]
        @category = params[:category]
        @grade = params[:grade]
        @sub_category = params[:sub_category]
        @chapter = params[:chapter]
        @concept_id = params[:concept_id]
        @level = params[:level]
        @student = params[:student]

    end
    
    
    private
    
    def get_unit_concept_counts(concept_id)

        ret = []

        unit_concept_counts = UnitConcept.get_level_count(concept_id)

        unit_concept_counts.each do |unit_concept_count|

            tmp = {
                exercise_yn: unit_concept_count.exercise_yn,
                level: unit_concept_count.level,
                count: unit_concept_count.count
            }

            ret << tmp

        end

        ret

    end
    
end

