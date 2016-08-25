class StudyHistoriesController < ApplicationController
    
    before_filter :authenticate_user!, only: [:create]
    before_action :authenticate_admin_user!, only: [:index, :detail]
    
    def detail
        @study_histories = StudyHistory.get_study_history_detail(params[:user_id])
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
        @study_histories = StudyHistory.get_study_history nil,page
        render :layout => 'layouts/admin_main'
    end

end
