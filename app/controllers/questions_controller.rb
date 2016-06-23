class QuestionsController < ApplicationController
    
    def create
        
        @question = Question.new(question_params)
        
        respond_to do |format|
            if @question.save
                format.html { redirect_to "/contents/#{params[:question][:unit_concept_id]}", notice: '질문하기가 성공적으로 등록되었습니다.' }
            end
        end
        
    end

    private
      
    def question_params
        params.require(:question).permit(:unit_concept_id, :to_user_id, :user_id, :title, :content, :file_name)
    end
    
end
