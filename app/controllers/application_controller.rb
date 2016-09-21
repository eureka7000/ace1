class ApplicationController < ActionController::Base
    
    protect_from_forgery with: :exception
    before_filter :prepare_exception_notifier
    
    private
    
    def authenticate_admin_user!
        
        if session[:admin].nil?
            redirect_to '/admins/login'
        end    
    end
    
    def prepare_exception_notifier
        request.env["exception_notifier.exception_data"] = {
            :current_user => current_user
        }
    end 
    
    def after_sign_in_path_for(resource)
        
        if session[:previous_url] == "/users/sign_in"
            root_path
        else    
            session[:previous_url]
        end    

    end    
       
end
