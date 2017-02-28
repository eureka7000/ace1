class QuestionsController < ApplicationController
    before_action :set_question, only: [:show, :edit, :update, :like]
    before_filter :authenticate_user!, only: [:update, :create, :like]
    before_action :authenticate_admin_user!, only: [:destroy]
    
    def like
        if @question.like.nil?
            @question.like = 1
        else
            @question.like = @question.like + 1
        end        

        @question.save
        
        ret = { status: "ok" }
        
        render :json => ret
        
    end    

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
        @questions = Question.all.paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 5 ).order(created_at: :desc)
        @latest_news = Blog.where('blog_type !=?', '8').order(id: :desc).first(5)
    end


    def create
        
        @question = Question.new(question_params)
        @question.like = 0

        #데이터를 보낸 url 주소를 받는다, 질문하기가 이용되는 곳이 여러곳이므로 보낸 주소를 받아 리턴해준다.
        url = params[:url]

        respond_to do |format|
            
            if @question.save
                
                # Sms 발송
                # unless params[:question][:to_user_id].blank?
                #     mento = User.find(params[:question][:to_user_id])
                #
                #     # unless mento.phone.nil?
                #     #     message = "#{current_user.user_name} 학생이 선생님에게 질문한 내용이 유레카매스에 등록되었습니다."
                #     #     TwilioSms.sendSMS("+82"+mento.phone, message)
                #     # end
                #
                #     # Mail 발송
                #     if params[:concept_id].nil?
                #         @unit_concept = UnitConcept.find(@question.unit_concept_id)
                #         @concept = Concept.find(@unit_concept.concept_id)
                #     else
                #         @concept = Concept.find(params[:concept_id])
                #     end
                #     UserMailer.noti_question(mento, current_user, @question, @concept).deliver_later!
                # end

                # 관계된 모든 선생님, 멘토에게 Email, SMS 전송
                @related_people = UserRelation.where('user_id = ? and relation_type != ?', current_user.id, 'parent')

                unless @related_people.blank?
                    if params[:concept_id].nil?
                        @unit_concept = UnitConcept.find(@question.unit_concept_id)
                        @concept = Concept.find(@unit_concept.concept_id)
                    else
                        @concept = Concept.find(params[:concept_id])
                    end
                    @related_people.each do |related_person|
                        related_teacher = User.find(related_person.related_user_id)

                        # Sending Email
                        UserMailer.noti_question(related_teacher, current_user, @question, @concept).deliver_later!

                        # Sening SMS
                        unless related_teacher.phone.blank?
                            message = "#{current_user.user_name} 학생이 선생님에게 질문한 내용이 유레카매스에 등록되었습니다."
                            TwilioSms.sendSMS("+82"+related_teacher.phone, message)
                        end
                    end
                end

                format.html { redirect_to url, notice: '질문하기가 성공적으로 등록되었습니다.' }

            end
        end
        
    end


    def show
        @replies1 = Reply.where('question_id = ? and depth = ?', params[:id], 1)
        @latest_news = Blog.where('blog_type !=?', '8').order(id: :desc).first(5)

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
        params.require(:question).permit(:unit_concept_id, :to_user_id, :user_id, :title, :content, :file_name, :confirm_yn, :like)
    end
    
end
