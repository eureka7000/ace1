class StudyHistoriesController < ApplicationController
    
    before_filter :authenticate_user!, only: [:create]
    before_action :authenticate_admin_user!, only: [:index]
    before_action :set_study_history, only: [:show, :edit, :update, :destroy]
    
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
        @study_histories = StudyHistory.all.paginate( :page => page, :per_page => 30 ).order(id: :desc)
        render :layout => 'layouts/admin_main'
    end

end
