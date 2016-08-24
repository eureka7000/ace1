class StudyHistoriesController < ApplicationController
    
    before_filter :authenticate_user!, only: [:create]
    before_action :authenticate_admin_user!, only: [:index, :detail]
    
    def detail
        
        @study_histories = StudyHistory.find_by_sql(
            "select a.unit_concept_id, b.name as unit_concept_name, b.id, c.concept_name, c.id,
        	    sum(case when a.segment = 'concept' and a.status = 'start' then 1 else 0 end) as concept_start,
                sum(case when a.segment = 'concept' and a.status = 'finish' then 1 else 0 end) as concept_finish,
                sum(case when a.segment = 'concept_explanation' and a.status = 'start' then 1 else 0 end) as concept_explanation_start,
        	    sum(case when a.segment = 'concept_explanation' and a.status = 'finish' then 1 else 0 end) as concept_explanation_finish,
                sum(case when a.segment = 'exercise' and a.status = 'start' then 1 else 0 end) as exercise_start,
        	    sum(case when a.segment = 'exercise' and a.status = 'finish' then 1 else 0 end) as exercise_finish,
                sum(case when a.segment = 'video' and a.status = 'start' then 1 else 0 end) as video,
        	    sum(case when a.segment = 'self_evaluation' and a.status = 'start' then 1 else 0 end) as self_evaluation   
             from study_histories a, unit_concepts b, concepts c
             where a.user_id = #{params[:user_id]}
             and a.unit_concept_id = b.id
             and b.concept_id = c.id
             group by a.unit_concept_id
             order by c.id, b.id")
       
        render :layout => 'layouts/admin_main'       
        
    end    
    
    def create
        
        ret = {} 
        
        if StudyHistory.update_study_history(params[:study_history])
            ret = { status: 'ok' }            
        else 
            ret = { status: 'fail' }
        end    
        
        render json: ret            

    end
    
    def index
        page = params[:page].blank? ? 1 : params[:page]
        @study_histories = StudyHistory.get_study_history('',page)
        render :layout => 'layouts/admin_main'
    end

end
