class ContentsController < ApplicationController

    before_action :authenticate_user!

    def index
        
        @view_type = params[:view_type].blank? ? '1' : params[:view_type]
        @step = params[:step].blank? ? '1' : params[:step]
        @category = params[:category]
        @sub_category = params[:sub_category]
        
        if @step == '3'
            @concepts = Concept.where('category = ? and sub_category = ?', @category, @sub_category)
        end    
        
    end

end
