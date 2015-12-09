class ConfirmationsController < Devise::ConfirmationsController

    private
    
    def after_confirmation_path_for(resource_name, resource)
        logger.debug '******************' + current_user.inspect
        '/mypages/settings?active_tab=2'
    end    
  
end 