class MypagesController < ApplicationController
    
    before_filter :authenticate_user!
    skip_before_filter :verify_authenticity_token, :only => :payment_return
    
    def study_progress_check
        @click = 'study_progress'
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

        link_query = "select id, name, user_id, concept_id, memo, evaluation, comment, created_at, history, what from (

	            select a.id, a.name, b.user_id, a.concept_id, '' as memo, b.evaluation, b.comment, b.created_at, '' as history, 'evaluation' as what
                    from unit_concepts a, (
		                select ori.user_id, ori.unit_concept_id, ori.evaluation, ori.comment, ori.created_at from unit_concept_self_evaluations ori, (
				        SELECT user_id, unit_concept_id, max(created_at) creat FROM unit_concept_self_evaluations
				        where user_id = 8
				        group by user_id, unit_concept_id
		             ) last_eval
		             where ori.created_at = last_eval.creat
	                 ) b
	                 where a.id = b.unit_concept_id

	                 union all

	                 select c.id, c.name, e.user_id, c.concept_id, e.memo, '' as evaluation, '' as comment, '' as created_at, GROUP_CONCAT(e.ox SEPARATOR ' ') as history, 'exercise' as what
                     from unit_concepts c, (
		                 select a.id, a.unit_concept_id, a.memo, b.ox, b.user_id from unit_concept_descs a, unit_concept_exercise_histories b
		                 where a.id = b.unit_concept_desc_id and b.user_id = 8
	                 ) e
	                 where c.id = e.unit_concept_id
                     group by c.id, c.name, e.user_id, e.memo

                     ) d
                     order by id, what, memo;"

        @evaluations = UnitConcept.find_by_sql(link_query)

        if current_user.user_types[0].user_type == 'school teacher' || current_user.user_types[0].user_type == 'mento'
            @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        end
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
end