class MypagesController < ApplicationController
    
    before_filter :authenticate_user!
    
    def overall

        @click = 'overall';
        @active = 'mypages'
       
        respond_to do |format|
            format.html
        end 
        
    end    

    def evaluation

        @click = 'evaluation';

        @unit_concept_exercise_histories = UnitConceptExerciseHistory.where(user_id: current_user.id).order(:unit_concept_desc_id).order(created_at: :desc)

    end


    def question_list

        @click = 'question_list'
        @questions = Question.where('to_user_id = ? || user_id = ?', current_user.id, current_user.id).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 ).order(created_at: :desc)

        if current_user.user_types[0].user_type == 'student'
            @type = 'student';
        elsif current_user.user_types[0].user_type == 'school teacher'
            @type = 'school teacher'
        end
    end

    
    def user_info

        @click = 'user_info';
        @active_tab = params[:active_tab] || '2'
        
        @schools = School.where('is_school = ?', (current_user.user_types[0].user_type == 'school teacher' ? '1' : '0') )
        
        respond_to do |format|
            format.html
        end         
    end    
    
end