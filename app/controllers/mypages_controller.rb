class MypagesController < ApplicationController
    
    def overall

        @active = 'mypages'
       
        respond_to do |format|
            format.html
        end 
        
    end    
    
end