class ApplicationController < ActionController::Base
    
    protect_from_forgery with: :exception
    
    private
    
    def authenticate_admin_user!
        
        logger.debug '********' + params[:except].inspect
        
        if session[:admin].nil?
            redirect_to '/admins/login'
        end    
    end
end
