class MypagesController < ApplicationController
    
    before_filter :authenticate_user!
    
    def overall

        @active = 'mypages'
       
        respond_to do |format|
            format.html
        end 
        
    end    
    
    
    def settings
        
        @active_tab = params[:active_tab] || '2'
        
        @schools = School.where('is_school = 1')
        
        respond_to do |format|
            format.html
        end         
    end    
    
end