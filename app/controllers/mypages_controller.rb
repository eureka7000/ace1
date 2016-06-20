class MypagesController < ApplicationController
    
    before_filter :authenticate_user!
    
    def overall

        @active = 'mypages'
       
        respond_to do |format|
            format.html
        end 
        
    end    

    def evaluation
        @unit_concept_exercise_histories = UnitConceptExerciseHistory.where('user_id = ?', current_user.id)
        @unit_concept_exercise_solutions = UnitConceptExerciseSolution.all
    end

    
    def settings
        
        @active_tab = params[:active_tab] || '2'
        
        @schools = School.where('is_school = ?', (current_user.user_types[0].user_type == 'school manager' ? '1' : '0') )
        
        respond_to do |format|
            format.html
        end         
    end    
    
end