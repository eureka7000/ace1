class QuestionsController < ApplicationController
    before_action :set_question, only: [:show, :edit, :update, :destroy]

    def index
        @questions = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 10 ).order(created_at: :desc)
    end

    def create
        
        @question = Question.new(question_params)
        
        respond_to do |format|
            if @question.save
                format.html { redirect_to "/contents/#{params[:question][:unit_concept_id]}", notice: '질문하기가 성공적으로 등록되었습니다.' }
            end
        end
        
    end


    def show

    end

    private
    def set_question
        @question = Question.find(params[:id])
    end
    def question_params
        params.require(:question).permit(:unit_concept_id, :to_user_id, :user_id, :title, :content, :file_name)
    end
    
end
