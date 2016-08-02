class MypagesController < ApplicationController
    
    before_filter :authenticate_user!
    skip_before_filter :verify_authenticity_token, :only => :payment_return
    
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
        
    end
    
    def overall

        @click = 'overall'
        @active = 'mypages'
       
        respond_to do |format|
            format.html
        end 
        
    end    

    def evaluation

        @click = 'evaluation'

        @unit_concept_exercise_histories = UnitConceptExerciseHistory.where(user_id: current_user.id).order(:unit_concept_desc_id).order(created_at: :desc)

        if current_user.user_types[0].user_type == 'school teacher' || 'mento'
            @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        end
    end


    def question_list

        @click = 'question_list'
        @questions = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(created_at: :desc)

        if current_user.user_types[0].user_type == 'student'
            @type = 'student';
        elsif current_user.user_types[0].user_type == 'school teacher'
            @type = 'school teacher'
        elsif current_user.user_types[0].user_type == 'mento'
            @type = 'mento'
        end

        unless params[:student].blank?
            @questions = @questions.where('user_id = ?', params[:student]).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(:created_at)
        end

        unless params[:code].blank?
            @questions = @questions.where('unit_concept_id = ?', params[:code]).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(created_at: :desc)
        end

        @students = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).select(:user_id).distinct.order(:user_id)
        @codes = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).select(:unit_concept_id).distinct.order(:user_id)


        if current_user.user_types[0].user_type == 'school teacher' || 'mento'
            @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        end
    end

    
    def user_info

        @click = 'user_info';
        @active_tab = params[:active_tab] || '2'
        
        @schools = School.where('is_school = ?', (current_user.user_types[0].user_type == 'school teacher' ? '1' : '0') )


        if current_user.user_types[0].user_type == 'school teacher' || 'mento'
            @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count()
        end

        respond_to do |format|
            format.html
        end         
    end    
    
end