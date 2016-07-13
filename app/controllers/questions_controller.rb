class QuestionsController < ApplicationController
    before_action :set_question, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user!

    def index
        @questions = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(created_at: :desc)
    end


    def create
        
        @question = Question.new(question_params)
        
        respond_to do |format|
            
            if @question.save
                
                # Sms 발송
                mento = User.find(params[:question][:to_user_id])
                
                unless mento.phone.nil?
                    message = "#{current_user.user_name} 학생이 선생님에게 질문한 내용이 유레카매스에 등록되었습니다."                    
                    TwilioSms.sendSMS("+82"+mento.phone, message)
                end
                
                # Mail 발송
                logger.debug "mail sending..."
                UserMailer.noti_question(mento, current_user, @question).deliver
                logger.debug "mail sending end..."
                
                format.html { redirect_to "/contents/#{params[:question][:unit_concept_id]}", notice: '질문하기가 성공적으로 등록되었습니다.' }
            end
        end
        
    end


    def show
        @replies1 = Reply.where('question_id = ? and depth = ?', params[:id], 1).order(id: :asc)
        @replies2 = Reply.where('question_id = ? and depth = ?', params[:id], 2).order(id: :asc)
    end


    def update
        respond_to do |format|
            if @question.update(question_params)
                format.html { redirect_to @question, notice: 'Question was successfully updated.' }
                format.json { render :show, status: :ok, location: @question }
            else
                format.html { render :edit }
                format.json { render json: @question.errors, status: :unprocessable_entity }
            end
        end
    end

    private
    def set_question
        @question = Question.find(params[:id])
    end
    def question_params
        params.require(:question).permit(:unit_concept_id, :to_user_id, :user_id, :title, :content, :file_name)
    end
    
end
