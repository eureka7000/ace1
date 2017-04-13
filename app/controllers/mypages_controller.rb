class MypagesController < ApplicationController
    
    before_filter :authenticate_user!
    skip_before_filter :verify_authenticity_token, :only => [:payment_return, :juso_popup]

    layout '/layouts/mypages'

    def overall

        @click = 'overall';

        # 최근 공부한 개념
        unless current_user.study_histories.blank?
            @last_studied_unit_concept_id = current_user.study_histories.last.unit_concept_id
            @last_study_histories = StudyHistory.where('user_id=? and unit_concept_id=?', current_user.id, @last_studied_unit_concept_id)
        else
            @last_studied_unit_concept_id = 1
            @last_study_histories = nil
        end

        # logger.info "################   #{@last_study_histories.count}   ###################"

        unless @last_study_histories.nil?
            unit_concept_id = @last_studied_unit_concept_id
            count = UnitConceptDesc.get_unit_concept_desc_count(unit_concept_id)
            @progress_percent = @last_study_histories.count.to_f/count * 100
        end

        # 최근 질문들
        if current_user.user_types[0].user_type == 'student'
            @questions = Question.where('user_id = ?', current_user.id).order(created_at: :desc).limit(7)
        elsif current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'institute teacher' || current_user.user_types[0].user_type == 'mento'
            # 연결된 학생들의 질문만 보여주도록 한다.
            @questions = Question.get_question_at_overall(current_user.id)
        end

        # 공지사항
        @latest_notices = Blog.where('blog_type = ?', '5').order(id: :desc).first(7)

        # 관계된 사람들
        @related_users = UserRelation.where('related_user_id = ? and confirmed_at != ?', current_user.id, nil?)

        # 개념 자기 평가 이력들
        @self_evaluations = UnitConceptSelfEvaluation.where(user_id: current_user.id).order(created_at: :desc).limit(5)

        # 최근 참여한 토론방
        @discussion_rooms = DiscussionHistory.where('user_id = ?', current_user.id)

    end

    def user_info

        @click = 'user_info';
        @active_tab = params[:active_tab] || '2'

        @schools = School.where('is_school = ?', (current_user.user_types[0].user_type == 'school teacher' ? '1' : '0') )

        @requests = UserRelation.where('related_user_id=? and confirm_status=?', current_user.id, 'requested').order(:request_date)

        # if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
        #     @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        # end
        @questions_number = Question.get_question_number(current_user.id)

        respond_to do |format|
            format.html
        end
    end

    def question_list

        @click = 'question_list'
        page = params[:page].blank? ? 1 : params[:page]

        if current_user.user_types[0].user_type == 'student'
            @questions = Question.where('user_id = ?', current_user.id).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(created_at: :desc)
            @students = Question.where('user_id = ?', current_user.id).select(:user_id).distinct.order(:user_id)
            @codes = Question.where('user_id = ?', current_user.id).select(:unit_concept_id).distinct.order(:user_id)

            unless params[:student].blank?
                @questions = @questions.where('user_id = ?', params[:student]).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(:created_at)
            end

            unless params[:code].blank?
                @questions = @questions.where('unit_concept_id = ?', params[:code]).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(created_at: :desc)
            end

        elsif current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'institute teacher' || current_user.user_types[0].user_type == 'mento'
            @students = Question.get_question_user(current_user.id, current_user.user_types[0].user_type)
            @codes = Question.get_question_code(current_user.id, current_user.user_types[0].user_type)
            @questions = Question.get_question_from_search(current_user.id, params[:student], params[:code], page)
        end


        # if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
        #     @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        # end

        # @questions_number = 0
        # @related_users = UserRelation.where('related_user_id = ?', current_user.id)
        # @related_users.each do |related_user|
        #     related_user.user.questions.each do |question|
        #         if question.confirm_yn = 'N'
        #             @questions_number += 1
        #         end
        #     end
        # end

        @questions_number = Question.get_question_number(current_user.id)

    end

    def study_progress_detail
        @click = 'study_progress'
        @study_histories = StudyHistory.get_study_history_detail(params[:user_id])
        @student = User.find(params[:user_id])
    end

    def self_evaluation_show
        @self_evaluations = UnitConceptSelfEvaluation.where('user_id = ? and unit_concept_id = ?', params[:user_id], params[:unit_concept_id]).order('created_at desc limit 3')

        ret = []

        @self_evaluations.each do | se |

            tmp = {
                    id: se.id,
                    unit_concept_id: se.unit_concept_id,
                    unit_concept_name: se.unit_concept.name,
                    evaluation: se.evaluation,
                    comment: se.comment,
                    date: se.created_at.in_time_zone("Asia/Seoul").strftime("%Y/%m/%d %H:%M"),
                    # updated_at: se.updated_at,
                    user_id: se.user_id
            }

            ret << tmp

        end

        render :json => ret

    end

    def unit_concept_exercise_show

        @unit_concept_exercises_histories = UnitConceptExerciseHistory.get_student_exercise_histories(params[:user_id], params[:unit_concept_id])

        ret = []

        @unit_concept_exercises_histories.each do | exercise |

            tmp = {
                    unit_concept_id: exercise.unit_concept_id,
                    unit_concept_name: exercise.unit_concept_name,
                    unit_concept_desc_id: exercise.unit_concept_desc_id,
                    memo: exercise.memo,
                    user_id: exercise.user_id,
                    history: exercise.history
            }

            ret << tmp

        end

        render :json => ret
    end

    def student_management
        @click = 'study_progress'
        page = params[:page].blank? ? 1 : params[:page]
        @study_histories = StudyHistory.get_study_history(current_user.id, page)
        # if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
        #     @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        # end
        @questions_number = Question.get_question_number(current_user.id)

        @groups = Group.where('user_id = ?', current_user.id)
    end

    def get_textbook_price

        goods_list = params[:goods_list]

        # logger.info "*****  #{goods_list}"
        # logger.info "*****  #{goods_list.size}"

        total_price = 0

        (0..goods_list.size-1).each do |index|
            total_price = total_price + Textbook.find_by_name("#{goods_list[index]}").price
            # logger.info "$$$$$$$$  #{total_price}"
        end

        # 데이터 값 전달 부분 수정
        ret = { total_price: total_price }
        render json: ret
    end

    def juso_popup
        
        @inputYn = params[:inputYn]
        @roadFullAddr = params[:roadFullAddr]
        @roadAddrPart1 = params[:roadAddrPart1]
        @roadAddrPart2 = params[:roadAddrPart2]
        @engAddr = params[:engAddr]    
        @jibunAddr = params[:jibunAddr]
        @zipNo = params[:zipNo]
        @addrDetail = params[:addrDetail]
        @admCd = params[:admCd]
        @rnMgtSn = params[:rnMgtSn]
        @bdMgtSn = params[:bdMgtSn]
        
        render layout: nil
    end    

    def request_textbook
        
        @click = 'textbook'
        @mid = Rails.application.config.inicis[:mid]
        # @order_number = current_user.id.to_s + "#" + Time.now().strftime('%Y%m%d%H%M%S')
        @price = 1000
        @timestamp = DateTime.now.strftime('%Q')
        @order_number = @mid + "_" + @timestamp        
        @params = {
            oid: @order_number,
            price: @price,
            timestamp: @timestamp
        }

        @textbooks = Textbook.select(:name, :price).distinct.order(:sub_category)

        @sign = InicisPayment.make_hash(@params.to_query)  
        @m_key = InicisPayment.make_hash(Rails.application.config.inicis[:sign_key])
        
        # 결제이력
        @payments = Payment.where('user_id = ? and payment_status = ?',current_user.id, 'paid').order(id: :desc)


        # if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
        #     @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        # end
        @questions_number = Question.get_question_number(current_user.id)

    end

    def payment
        
        @click = 'payment'
        @mid = Rails.application.config.inicis[:mid]
        # @order_number = current_user.id.to_s + "#" + Time.now().strftime('%Y%m%d%H%M%S')
        @price = 1000
        @timestamp = DateTime.now.strftime('%Q')
        @order_number = @mid + "_" + @timestamp        
        @params = {
            oid: @order_number,
            price: @price,
            timestamp: @timestamp
        }

        @sign = InicisPayment.make_hash(@params.to_query)  
        @m_key = InicisPayment.make_hash(Rails.application.config.inicis[:sign_key])
        
        # 결제이력
        @payments = Payment.where('user_id = ? and payment_status = ?',current_user.id, 'paid').order(id: :desc)


        # if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
        #     @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        # end
        @questions_number = Question.get_question_number(current_user.id)

    end

    def evaluation

        @click = 'evaluation'

        # link_query = "select id, name, user_id, concept_id, memo, evaluation, comment, created_at, history, what from (
        #
        #                 select a.id, a.name, b.user_id, a.concept_id, '' as memo, b.evaluation, b.comment, b.created_at, '' as history, 'evaluation' as what
        #             from unit_concepts a, (
        #                         select ori.user_id, ori.unit_concept_id, ori.evaluation, ori.comment, ori.created_at from unit_concept_self_evaluations ori, (
        #                         SELECT user_id, unit_concept_id, max(created_at) creat FROM unit_concept_self_evaluations
        #                         where user_id = #{current_user.id}
        #                         group by user_id, unit_concept_id
        #                      ) last_eval
        #                      where ori.created_at = last_eval.creat
        #                      ) b
        #                      where a.id = b.unit_concept_id
        #
        #                      union all
        #
        #                      select c.id, c.name, e.user_id, c.concept_id, e.memo, '' as evaluation, '' as comment, '' as created_at, GROUP_CONCAT(e.ox SEPARATOR ' ') as history, 'exercise' as what
        #              from unit_concepts c, (
        #                          select a.id, a.unit_concept_id, a.memo, b.ox, b.user_id from unit_concept_descs a, unit_concept_exercise_histories b
        #                          where a.id = b.unit_concept_desc_id and b.user_id = #{current_user.id}
        #                      ) e
        #                      where c.id = e.unit_concept_id
        #              group by c.id, c.name, e.user_id, e.memo
        #
        #              ) d
        #              order by id, what, memo;"
        #
        # @evaluations = UnitConcept.find_by_sql(link_query)
        #
        # if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
        #     @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        # end
        
        @evaluations = UnitConceptSelfEvaluation.where(user_id: current_user.id).order(created_at: :desc)
        
    end

    def discussion_management
        @click = 'discussion_management'
        @discussions = Discussion.where('user_id = ? or sub_leader = ?', current_user.id, current_user.id).order(:start_date => :desc)
    end

    def user_image_upload

        @user = User.find(params[:user_id])
        @user.user_img = params[:user_img]

        url = params[:url]

        respond_to do |format|
            if @user.save
                format.html { redirect_to url, notice: 'user profile image was successfully uploaded.' }
            end
        end
    end

    def find_school_admin
        @manager = Admin.find_by_school_id(params[:school_id].to_i)
        email = @manager.email.to_s

        respond_to do |format|
            format.json { render :json => { email: email } }
        end
    end

end