class UnitConceptExerciseHistoriesController < ApplicationController

    before_filter :authenticate_user!

    def create
        
        @unit_concept_exercise_history = UnitConceptExerciseHistory.new(unit_concept_exercise_history_params)
        
        ret = { ret: "success" }
        ret_fail = { ret: "fail" }
        
        respond_to do |format|
            
            if @unit_concept_exercise_history.save
                format.json { render json: ret }
            else
                format.json { render ret_fail }
            end            
            
        end
        
    end
    
    private

    def unit_concept_exercise_history_params
        params.require(:unit_concept_exercise_history).permit(:unit_concept_desc_id, :user_id, :ox)
    end
    
end