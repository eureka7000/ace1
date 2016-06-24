class UnitConceptExerciseSolutionsController < ApplicationController

    before_action :authenticate_admin_user!
    before_action :set_unit_concept_exercise_solution, only: [:destroy]

    def create
        
        @unit_concept_exercise_solution = UnitConceptExerciseSolution.new(unit_concept_exercise_solution_params)
        
        respond_to do |format|
            
            if @unit_concept_exercise_solution.save
                format.html { redirect_to "/unit_concepts/#{params[:unit_concept_id]}", notice: 'Explanation was successfully created.' }
            else
                format.html { redirect_to "/unit_concepts/#{params[:unit_concept_id]}?unit_concept_desc_id=#{params[:unit_concept_exercise_solution][:unit_concept_desc_id]}&solution_error=true&messages=#{@unit_concept_exercise_solution.errors.full_messages}" }
            end            
            
        end
        
    end
    
    def destroy
        @unit_concept_exercise_solution.destroy
        respond_to do |format|
            format.json { head :no_content }
        end        
    end    

    private
    
    def set_unit_concept_exercise_solution
      @unit_concept_exercise_solution = UnitConceptExerciseSolution.find(params[:id])
    end    

    def unit_concept_exercise_solution_params
        params.require(:unit_concept_exercise_solution).permit(:unit_concept_desc_id, :code, :file_name, :ox, :memo, :link)
    end
    
end