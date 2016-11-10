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

        if session[:previous_url] == '/'
            if current_user.user_types.first.user_type == 'student'
                if current_user.study_histories.last.nil?
                    '/'
                else
                    "/contents/#{current_user.study_histories.last.unit_concept_id}"
                end
            else
                root_url
            end
        else
            session[:previous_url].to_s
        end

        # if session[:previous_url] == "/users/sign_in"
        #     if current_user.user_types.first.user_type == 'student'
        #         if current_user.study_histories.last.nil?
        #             "/contents/1"
        #         else
        #             "/contents/#{current_user.study_histories.last.unit_concept_id}"
        #         end
        #     else
        #         root_url
        #     end
        # else
        #     if session[:previous_url] == '/'
        #         if current_user.user_types.first.user_type == 'student'
        #             if current_user.study_histories.last.nil?
        #                 "/contents/1"
        #             else
        #                 "/contents/#{current_user.study_histories.last.unit_concept_id}"
        #             end
        #         else
        #             root_url
        #         end
        #     else
        #         session[:previous_url]
        #     end
        # end

    end
       
end
