class ContentsController < ApplicationController

    before_action :authenticate_user!

    def index
        
        @view_type = params[:view_type].blank? ? '1' : params[:view_type]
        @step = params[:step].blank? ? '1' : params[:step]
        @category = params[:category]
        
    end

end
