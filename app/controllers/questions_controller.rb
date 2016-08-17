class QuestionsController < ApplicationController
    before_action :set_question, only: [:show, :edit, :update]
    before_filter :authenticate_user!, only: [:index, :update]

    def questions_list
        unless session[:admin].nil?

            @questions = Question.all.paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(created_at: :desc)

            unless params[:student].blank?
                @questions = Question.where('user_id = ?', params[:student]).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(created_at: :desc)
            end

            unless params[:code].blank?
                @questions = Question.where('unit_concept_id = ?', params[:code]).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(created_at: :desc)
            end

            @teachers_and_mentors = UserType.where('user_type = ?', 'mento' || 'teacher')
            @students = Question.group(:user_id).distinct(:user_id)
            @codes = Question.group(:unit_concept_id).distinct.order(:unit_concept_id)

            render layout: 'admin_main'
        end
    end

    def index
        @questions = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(created_at: :desc)

        @latest_news = Blog.order(id: :desc).first(5)
    end


    def create
        
        @question = Question.new(question_params)
        
        respond_to do |format|
            
            if @question.save
                
                # Sms 발송
                unless params[:question][:to_user_id].blank?
                    mento = User.find(params[:question][:to_user_id])

                    unless mento.phone.nil?
                        message = "#{current_user.user_name} 학생이 선생님에게 질문한 내용이 유레카매스에 등록되었습니다."
                        TwilioSms.sendSMS("+82"+mento.phone, message)
                    end

                    # Mail 발송
                    if params[:concept_id].nil?
                        @unit_concept = UnitConcept.find(@question.unit_concept_id)
                        @concept = Concept.find(@unit_concept.concept_id)
                    else
                        @concept = Concept.find(params[:concept_id])
                    end
                    UserMailer.noti_question(mento, current_user, @question, @concept).deliver
                end

                unless params[:concept_id].nil?
                    unless params[:synthesis].nil?
                        format.html { redirect_to "/contents/exercise?concept_id=#{params[:concept_id]}&unit_concept_id=#{params[:question][:unit_concept_id]}&exercise_type=concept_exercise&synthesis=1", notice: '질문하기가 성공적으로 등록되었습니다.' }
                    else
                        format.html { redirect_to "/contents/exercise?concept_id=#{params[:concept_id]}&unit_concept_id=#{params[:question][:unit_concept_id]}", notice: '질문하기가 성공적으로 등록되었습니다.' }
                    end
                else
                    format.html { redirect_to "/contents/#{params[:question][:unit_concept_id]}", notice: '질문하기가 성공적으로 등록되었습니다.' }
                end

            end
        end
        
    end


    def show
        @replies1 = Reply.where('question_id = ? and depth = ?', params[:id], 1)
        @replies2 = Reply.where('question_id = ? and depth = ?', params[:id], 2)

        @latest_news = Blog.order(id: :desc).first(4)

        unless session[:admin].nil?
            render layout: 'admin_main'
        end
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

    # DELETE /questions/1
    # DELETE /questions/1.json
    def destroy
        unless session[:admin].nil?
            @question = Question.find(params[:id])
        end
        @question.destroy
        respond_to do |format|
            format.html { redirect_to '/questions/questions_list', notice: 'Question was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    def set_question
        @question = Question.find(params[:id])
    end
    def question_params
        params.require(:question).permit(:unit_concept_id, :to_user_id, :user_id, :title, :content, :file_name, :confirm_yn)
    end
    
end
