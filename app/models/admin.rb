class Admin < ActiveRecord::Base
    
    ADMIN_TYPES = {
        "admin" => "admin",
        "school manager" => "학교 관리자",
        "institute manager" => "학원 관리자"
    }    
    
    def create
#       @admin = Admin.new(params[:admin][:user]) 

        
    end    
    
end
