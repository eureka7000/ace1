class ConceptExercisesController < ApplicationController

    before_action :authenticate_admin_user!
    before_action :set_concept_exercise, only: [:show, :edit, :update, :destroy]
    before_action :set_return_param, only: [:create, :destroy]

    def create
        
        # @concept_exercise = ConceptExercise.new(concept_exercise_params)
        # @concept_exercise.save
        #
        # @concept = Concept.find(params[:concept_exercise][:concept_id])
        
        if params[:concept_exercise][:desc_type] == 'i'
        
            params[:concept_exercise][:file_name].each do | image |
            
                concept_exercise = ConceptExercise.new
            
                filename = image.original_filename.split('.')[0]
                div = filename.last(1)
            
                if div == 'c'
                    concept_exercise.desc_type = '1'
                elsif div == 'e'
                    concept_exercise.desc_type = '2'
                elsif div == 's'
                    concept_exercise.desc_type = '3'
                elsif div == 'a'    
                    concept_exercise.desc_type = '7'
                end
            
                concept_exercise.memo = filename
                concept_exercise.file_name = image
                concept_exercise.concept_id = params[:concept_exercise][:concept_id]
                concept_exercise.save
            
            end
            
        else
            concept_exercise = ConceptExercise.new(concept_exercise_params)
            concept_exercise.save
        end                
        
        respond_to do |format|
            format.html { redirect_to "/concepts/#{params[:concept_exercise][:concept_id]}/exercise?desc_type=#{params[:concept_exercise][:desc_type]}&#{@return_param}", notice: 'Explanation Desc was successfully created.' }
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
        params.require(:concept_exercise).permit(:memo, :file_name, :concept_id, :desc_type, :video, :link, :width, :height)
    end
    
    def set_return_param
        @return_param = "page=#{params[:page]}&category=#{params[:category]}&sub_category=#{params[:sub_category]}&exercise_yn=#{params[:exercise_yn]}"
    end    
    
end