class MypagesController < ApplicationController
    
    before_filter :authenticate_user!
    skip_before_filter :verify_authenticity_token, :only => [:payment_return, :juso_popup]

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
        
    end

    def study_progress_detail
        @click = 'study_progress'
        @study_histories = StudyHistory.get_study_history_detail(params[:user_id])
        @student = User.find(params[:user_id])
    end    


    def student_management
        @click = 'study_progress'
        page = params[:page].blank? ? 1 : params[:page]
        @study_histories = StudyHistory.get_study_history(current_user.id, page)
        if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
            @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        end

        @requests = UserRelation.where('related_user_id=? and confirm_status=?', current_user.id, 'requested').order(:request_date)

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


        if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
            @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        end
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


    def question_list

        @click = 'question_list'
        @questions = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(created_at: :desc)

        unless params[:student].blank?
            @questions = @questions.where('user_id = ?', params[:student]).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(:created_at)
        end

        unless params[:code].blank?
            @questions = @questions.where('unit_concept_id = ?', params[:code]).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(created_at: :desc)
        end

        @students = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).select(:user_id).distinct.order(:user_id)
        @codes = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).select(:unit_concept_id).distinct.order(:user_id)


        if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
            @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        end
    end


    
    def user_info

        @click = 'user_info';
        @active_tab = params[:active_tab] || '2'
        
        @schools = School.where('is_school = ?', (current_user.user_types[0].user_type == 'school teacher' ? '1' : '0') )


        if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
            @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        end

        respond_to do |format|
            format.html
        end

        if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
            @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        end
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