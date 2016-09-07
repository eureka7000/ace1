class ConceptExercisesController < ApplicationController

    before_action :authenticate_admin_user!
    before_action :set_concept_exercise, only: [:show, :edit, :update, :destroy]
    before_action :set_return_param, only: [:create, :destroy]

    def create
        
        @concept_exercise = ConceptExercise.new(concept_exercise_params)
        @concept_exercise.save
        
        @concept = Concept.find(params[:concept_exercise][:concept_id])

        respond_to do |format|
            format.html { redirect_to "/concepts/#{@concept.id}/exercise?desc_type=#{params[:concept_exercise][:desc_type]}&#{@return_param}", notice: 'Explanation Desc was successfully created.' }
        end
        
    end
    
    def destroy
        
        concept = @concept_exercise.concept
        @concept_exercise.destroy
        
        respond_to do |format|
            format.html { redirect_to "/concepts/#{concept.id}/exercise?#{@return_param}" , notice: 'successfully destroyed.' }
            format.json { head :no_content }
        end
        
    end
    
    def update 
        ret = { status: 'ok' }
        
        if @concept_exercise.update(concept_exercise_params)
            render json: ret
        end
    end    

    private
    
    def set_concept_exercise
        @concept_exercise = ConceptExercise.find(params[:id])
    end    

    def concept_exercise_params
        params.require(:concept_exercise).permit(:memo, :file_name, :concept_id, :desc_type, :video, :link)
    end
    
    def set_return_param
        @return_param = "page=#{params[:page]}&category=#{params[:category]}&sub_category=#{params[:sub_category]}&exercise_yn=#{params[:exercise_yn]}"
    end    
    
end