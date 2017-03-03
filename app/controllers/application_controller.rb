class ApplicationController < ActionController::Base
    
    protect_from_forgery with: :exception
    before_filter :prepare_exception_notifier, :check_concurrent_session

    def check_concurrent_session
        if is_already_logged_in?
            sign_out_and_redirect(current_user)
        end
    end

    def is_already_logged_in?
        current_user && !(session[:token] == current_user.login_token)
    end

    def after_sign_out_path_for(resource)
        # 동시 접속하여 로그아웃 되었을 때 로그아웃을 알리는 화면 보여주기
        '/homes/log_out'
        # root_path
    end

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

            '/mypages/overall' # 로그인 시 경로 변경

            # if current_user.user_types.first.user_type == 'student'
            #     if current_user.study_histories.last.nil?
            #         '/'
            #     else
            #         "/contents/#{current_user.study_histories.last.unit_concept_id}"
            #     end
            # else
            #     root_url
            # end
        else
            # session[:previous_url].to_s
            '/mypages/overall'
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
